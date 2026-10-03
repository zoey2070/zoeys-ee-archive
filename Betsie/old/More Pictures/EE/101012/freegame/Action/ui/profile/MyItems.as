package ui.profile
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import items.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;

    public class MyItems extends Sprite
    {
        private var itemcontent:Box;
        private var itemscrollbox:ScrollBox;
        private var itemlist:Rows;
        private var smilies:FillBox;
        private var blocks:FillBox;

        public function MyItems()
        {
            this.itemcontent = new Box();
            this.itemcontent.margin(0, 0, 0, 0);
            this.itemlist = new Rows();
            this.smilies = new FillBox(0);
            this.blocks = new FillBox(2);
            this.itemscrollbox = new ScrollBox().margin(0, 0, 0, 0).add(new Box().margin(0, 0, 0, 0).add(this.itemlist));
            this.itemcontent.add(new Box().margin(0, 0, 0, 0).add(this.itemscrollbox));
            this.itemlist.spacing(1);
            this.itemlist.addChild(new Label("Smilies", 15, "left", 16777215, false, "system"));
            this.itemlist.addChild(this.smilies);
            this.itemlist.addChild(new Label("Blocks", 15, "left", 16777215, false, "system"));
            this.itemlist.addChild(this.blocks);
            this.refreshItems();
            addChild(this.itemcontent);
            addEventListener(Event.EXIT_FRAME, this.handleUpdateItemScrollbox, false, 0, true);
            Shop.addEventListener(ShopEvent.ITEM_AQUIRED, this.handleShopUpdate);
            return;
        }// end function

        private function handleShopUpdate(event:Event) : void
        {
            this.refreshItems();
            return;
        }// end function

        private function refreshItems() : void
        {
            var _loc_5:ItemSmiley = null;
            var _loc_6:ItemBrickPackage = null;
            var _loc_7:Vector.<ItemBrick> = null;
            var _loc_8:int = 0;
            var _loc_9:ItemBrick = null;
            var _loc_10:int = 0;
            while (this.smilies.numChildren > 0)
            {
                
                this.smilies.removeChildAt(0);
            }
            while (this.blocks.numChildren > 0)
            {
                
                this.blocks.removeChildAt(0);
            }
            var _loc_1:* = Global.playerObject.haveSmileyPackage ? (true) : (false);
            var _loc_2:* = ItemManager.smilies;
            var _loc_3:int = 0;
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_5 = _loc_2[_loc_3];
                if (_loc_5.payvaultid == "" || Global.client.payVault.has(_loc_5.payvaultid) || _loc_5.payvaultid == "pro" && _loc_1)
                {
                    this.smilies.addChild(new ProfileSmiley(_loc_5));
                }
                _loc_3++;
            }
            var _loc_4:* = ItemManager.brickPackages;
            _loc_3 = 0;
            while (_loc_3 < _loc_4.length)
            {
                
                _loc_6 = _loc_4[_loc_3];
                _loc_7 = new Vector.<ItemBrick>;
                _loc_8 = 0;
                while (_loc_8 < _loc_6.bricks.length)
                {
                    
                    _loc_9 = _loc_6.bricks[_loc_8];
                    if (!_loc_9.requiresAdmin)
                    {
                        if (_loc_9.payvaultid == "" || Global.client.payVault.has(_loc_9.payvaultid) || _loc_9.payvaultid == "pro" && _loc_1)
                        {
                            _loc_10 = 0;
                            while (_loc_10 < (Global.client.payVault.count(_loc_9.payvaultid) || 1))
                            {
                                
                                _loc_7.push(_loc_9);
                                if (_loc_9.payvaultid != "brickdiamond")
                                {
                                    break;
                                }
                                _loc_10++;
                            }
                        }
                    }
                    _loc_8++;
                }
                if (_loc_7.length)
                {
                    this.blocks.addChild(new ProfileBrickPackage(_loc_6, _loc_7));
                }
                _loc_3++;
            }
            return;
        }// end function

        protected function handleUpdateItemScrollbox(event:Event) : void
        {
            removeEventListener(Event.EXIT_FRAME, this.handleUpdateItemScrollbox);
            this.itemscrollbox.refresh();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this.itemcontent.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this.itemcontent.height = param1;
            return;
        }// end function

    }
}
