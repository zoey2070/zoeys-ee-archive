package ui.shop
{
    import __AS3__.vec.*;
    import data.*;
    import flash.display.*;
    import flash.events.*;
    import sample.ui.components.*;
    import sample.ui.components.scroll.*;
    import ui.*;

    public class BaseShop extends MovieClip
    {
        protected const GRID_SPACING_H:int = 10;
        protected const GRID_SPACING_V:int = 10;
        private var tabbar:TabBar;
        protected var grid:ShopGrid;
        protected var all_items:Vector.<ShopItemData>;
        private var current_items:Vector.<ShopItemData>;
        protected var scrollbox:ScrollBox;
        protected var content:Box;
        protected var scrollcontainer:GridScrollContaioner;
        protected var mouseovercontainer:Sprite;

        public function BaseShop(param1:int, param2:Number = 10, param3:Number = 10)
        {
            var span:* = param1;
            var spacing_h:* = param2;
            var spacing_v:* = param3;
            this.grid = new ShopGrid(span, spacing_h, spacing_v);
            this.content = new Box();
            this.content.margin(0, 0, 0, 0);
            addChild(this.content);
            this.scrollcontainer = new GridScrollContaioner();
            this.scrollbox = new ScrollBox(this.scrollcontainer).margin(0, 0, 0, 0);
            this.scrollbox.scrollMultiplier = 15;
            this.content.add(this.scrollbox);
            this.mouseovercontainer = new Sprite();
            addChild(this.mouseovercontainer);
            addEventListener(MouseEvent.MOUSE_WHEEL, function (event:MouseEvent) : void
            {
                scrollbox.scrollY = scrollbox.scrollY - event.delta * 15;
                mouseovercontainer.y = content.y + scrollcontainer.y;
                return;
            }// end function
            );
            addEventListener(ShopItemEvent.MOUSE_OVER, this.handleShopItemMouse, false, 0, true);
            addEventListener(ShopItemEvent.MOUSE_OUT, this.handleShopItemMouse, false, 0, true);
            addEventListener(ShopItemEvent.BUY_ITEM, this.handleBuyItem, false, 0, true);
            addEventListener(ShopItemEvent.USE_ENERGY, this.handleUseEnergy, false, 0, true);
            Shop.addEventListener(ShopEvent.UPDATE, this.handleShopUpdate);
            return;
        }// end function

        protected function setContentSize(param1:Number, param2:Number, param3:Number, param4:Number) : void
        {
            this.content.x = param1;
            this.content.y = param2;
            this.content.width = param3;
            this.content.height = param4;
            return;
        }// end function

        protected function showItems(param1:Vector.<ShopItemData>) : void
        {
            while (this.mouseovercontainer.numChildren > 0)
            {
                
                this.mouseovercontainer.removeChildAt(0);
            }
            while (this.scrollcontainer.numChildren > 0)
            {
                
                this.scrollcontainer.removeChildAt(0);
            }
            this.scrollbox.scrollY = 0;
            this.current_items = param1;
            this.grid.setItems(this.current_items);
            this.grid.render();
            this.scrollbox.add(this.grid);
            return;
        }// end function

        private function handleShopUpdate(event:ShopEvent) : void
        {
            this.refreshShopItems();
            this.refreshGridItems();
            return;
        }// end function

        protected function refreshGridItems() : void
        {
            this.grid.refreshItems(this.all_items.concat());
            return;
        }// end function

        protected function refreshShopItems() : void
        {
            this.all_items = Shop.getShopItemData();
            return;
        }// end function

        protected function handleUseEnergy(event:ShopItemEvent) : void
        {
            var _loc_2:* = (event.target as ShopItem).itemdata;
            Shop.useEnergy(_loc_2.id, this.onShopInteractionComplete);
            return;
        }// end function

        protected function handleBuyItem(event:ShopItemEvent) : void
        {
            var _loc_2:* = (event.target as ShopItem).itemdata;
            Shop.useGems(_loc_2.id, _loc_2.priceGems, this.onShopInteractionComplete);
            return;
        }// end function

        protected function onShopInteractionComplete(param1:Boolean) : void
        {
            if (!param1)
            {
                this.refreshGridItems();
            }
            return;
        }// end function

        protected function handleShopItemMouse(event:ShopItemEvent) : void
        {
            var _loc_2:ShopItem = null;
            if (event.type == ShopItemEvent.MOUSE_OVER)
            {
                _loc_2 = event.target as ShopItem;
                if (this.scrollcontainer.y + _loc_2.y < 0)
                {
                    this.scrollbox.scrollY = _loc_2.y;
                }
                else if (this.scrollcontainer.y + _loc_2.y + ShopGrid.ITEM_HEIGHT > this.scrollbox.height)
                {
                    this.scrollbox.scrollY = _loc_2.y + ShopGrid.ITEM_HEIGHT - this.scrollbox.height + 1;
                }
                this.mouseovercontainer.x = this.content.x;
                this.mouseovercontainer.y = this.content.y + this.scrollcontainer.y;
                this.mouseovercontainer.addChild(event.target as ShopItem);
            }
            else
            {
                this.grid.addChild(event.target as ShopItem);
            }
            return;
        }// end function

    }
}
