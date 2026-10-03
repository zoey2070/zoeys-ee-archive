package ui.shop
{
    import __AS3__.vec.*;
    import data.*;
    import flash.display.*;
    import flash.events.*;

    public class ShopGrid extends Sprite
    {
        private var _span:int;
        private var rows:int = 0;
        private var shopitems:Vector.<ShopItem>;
        private var itemsHash:Object;
        private var itemdata:Vector.<ShopItemData>;
        private var h_spacing:Number = 0;
        private var v_spacing:Number = 0;
        public static const ITEM_WIDTH:int = 86;
        public static const ITEM_HEIGHT:int = 116;

        public function ShopGrid(param1:int, param2:Number, param3:Number)
        {
            this.itemdata = new Vector.<ShopItemData>;
            this.span = param1;
            this.h_spacing = param2;
            this.v_spacing = param3;
            addEventListener(ShopItemEvent.MOUSE_OVER, this.handleShopItemMouseOver, false, 0, true);
            return;
        }// end function

        public function get span() : int
        {
            return this._span;
        }// end function

        public function set span(param1:int) : void
        {
            this._span = param1;
            this.arrangeItemData();
            this.render();
            return;
        }// end function

        public function setSpacing(param1:Number, param2:Number) : void
        {
            this.h_spacing = param1;
            this.v_spacing = param2;
            this.render();
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            return;
        }// end function

        override public function get height() : Number
        {
            return (this.rows + 1) * (ITEM_HEIGHT + this.v_spacing) - this.v_spacing + 1;
        }// end function

        public function setItems(param1:Vector.<ShopItemData>) : void
        {
            this.itemdata = param1;
            this.sortItemData();
            this.arrangeItemData();
            return;
        }// end function

        public function refreshItems(param1:Vector.<ShopItemData>) : void
        {
            var _loc_3:ShopItem = null;
            var _loc_2:int = 0;
            while (_loc_2 < param1.length)
            {
                
                if (this.itemsHash[param1[_loc_2].id] != null)
                {
                    _loc_3 = this.itemsHash[param1[_loc_2].id];
                    _loc_3.setItemdata(param1[_loc_2]);
                }
                _loc_2++;
            }
            return;
        }// end function

        private function sortItemData() : void
        {
            this.itemdata.sort(function (param1:ShopItemData, param2:ShopItemData) : int
            {
                if (param1.isNew && !param2.isNew)
                {
                    return -1;
                }
                if (!param1.isNew && param2.isNew)
                {
                    return 1;
                }
                if (param1.isOnSale && !param2.isOnSale)
                {
                    return -1;
                }
                if (!param1.isOnSale && param2.isOnSale)
                {
                    return 1;
                }
                if (param1.type == ShopItemData.TYPE_OTHER && param2.type != ShopItemData.TYPE_OTHER)
                {
                    return 1;
                }
                if (param1.type != ShopItemData.TYPE_OTHER && param2.type == ShopItemData.TYPE_OTHER)
                {
                    return -1;
                }
                return param1.priceGems < param2.priceGems ? (-1) : (1);
            }// end function
            );
            return;
        }// end function

        private function arrangeItemData() : void
        {
            var _loc_3:Boolean = false;
            var _loc_4:int = 0;
            var _loc_5:ShopItemData = null;
            var _loc_1:* = new Vector.<ShopItemData>;
            this.rows = 0;
            var _loc_2:int = 0;
            while (this.itemdata.length > 0)
            {
                
                _loc_3 = false;
                _loc_4 = 0;
                while (_loc_4 < this.itemdata.length)
                {
                    
                    if (this.itemdata[_loc_4].span + _loc_2 <= this.span)
                    {
                        _loc_5 = this.itemdata.splice(_loc_4, 1)[0];
                        _loc_5.grid_x = _loc_2;
                        _loc_5.grid_y = this.rows;
                        _loc_1.push(_loc_5);
                        _loc_2 = _loc_2 + _loc_5.span;
                        _loc_3 = true;
                        break;
                    }
                    _loc_4++;
                }
                if (!_loc_3)
                {
                    _loc_2 = _loc_2 + (this.span - _loc_2);
                }
                if (_loc_2 == this.span)
                {
                    var _loc_6:String = this;
                    var _loc_7:* = this.rows + 1;
                    _loc_6.rows = _loc_7;
                    _loc_2 = 0;
                }
            }
            if (_loc_2 == 0)
            {
                var _loc_6:String = this;
                var _loc_7:* = this.rows - 1;
                _loc_6.rows = _loc_7;
            }
            this.itemdata = _loc_1;
            return;
        }// end function

        public function render() : void
        {
            var _loc_2:ShopItem = null;
            while (numChildren > 0)
            {
                
                removeChildAt(0);
            }
            this.shopitems = new Vector.<ShopItem>;
            this.itemsHash = {};
            var _loc_1:int = 0;
            while (_loc_1 < this.itemdata.length)
            {
                
                _loc_2 = new ShopItem(this.itemdata[_loc_1], this.itemdata[_loc_1].span * ITEM_WIDTH + (this.itemdata[_loc_1].span - 1) * this.h_spacing, ITEM_HEIGHT);
                _loc_2.x = this.itemdata[_loc_1].grid_x * (ITEM_WIDTH + this.h_spacing);
                _loc_2.y = this.itemdata[_loc_1].grid_y * (ITEM_HEIGHT + this.v_spacing);
                this.shopitems.push(_loc_2);
                this.itemsHash[this.itemdata[_loc_1].id] = _loc_2;
                addChild(_loc_2);
                _loc_1++;
            }
            return;
        }// end function

        protected function handleShopItemMouseOver(event:Event) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.shopitems.length)
            {
                
                if (this.shopitems[_loc_2] != event.target)
                {
                    this.shopitems[_loc_2].forceMouseOut();
                }
                _loc_2++;
            }
            addChild(event.target as ShopItem);
            return;
        }// end function

    }
}
