package ui.shop
{
    import __AS3__.vec.*;
    import com.greensock.*;
    import data.*;
    import flash.events.*;

    public class MyShop extends BaseShop
    {
        private var _width:Number = 343;
        private var _height:Number = 369;
        private var minishopitems:Vector.<ShopItemData>;

        public function MyShop()
        {
            this.minishopitems = new Vector.<ShopItemData>;
            super(6, 10, 10);
            if (!Shop.isInitiallyRefreshed())
            {
                return;
            }
            refreshShopItems();
            this.updateSize();
            this.refreshGridItems();
            addEventListener(ShopItemEvent.CLICK_ITEM, this.handleClickShopItem, false, 0, true);
            return;
        }// end function

        protected function handleClickShopItem(event:ShopItemEvent) : void
        {
            var _loc_2:* = event.target as ShopItem;
            if (_loc_2.itemdata.id == "shopmore")
            {
                dispatchEvent(new ShopEvent(ShopEvent.OPEN_MAINSHOP, true, false));
                TweenMax.delayedCall(0.2, _loc_2.forceMouseOut);
            }
            return;
        }// end function

        protected function handleShopMore(event:MouseEvent) : void
        {
            dispatchEvent(new ShopEvent(ShopEvent.OPEN_MAINSHOP, true, false));
            return;
        }// end function

        private function filterItems(param1:Vector.<ShopItemData>) : Vector.<ShopItemData>
        {
            var _loc_2:* = new Vector.<ShopItemData>;
            var _loc_3:int = 0;
            while (_loc_3 < param1.length)
            {
                
                if (param1[_loc_3].isNew || !param1[_loc_3].isClassic && (param1[_loc_3].energyUsed > 0 || param1[_loc_3].isGridFeatured))
                {
                    _loc_2.push(all_items[_loc_3]);
                }
                _loc_3++;
            }
            _loc_2.push(this.getShopMoreItem());
            return _loc_2;
        }// end function

        private function getShopMoreItem() : ShopItemData
        {
            var _loc_1:* = new ShopItemData("shopmore", ShopItemData.TYPE_OTHER, -1, 0, 0, -1, 0, 1, "Click here!", "", "shopitem_other", 0, false, false, false, false, false, false, false);
            Shop.setBitmapData(_loc_1);
            return _loc_1;
        }// end function

        override protected function refreshGridItems() : void
        {
            super.refreshGridItems();
            var _loc_1:* = this.filterItems(all_items);
            if (this.minishopitems.length != _loc_1.length)
            {
                this.minishopitems = _loc_1;
                showItems(this.minishopitems.concat());
                this.updateSize();
            }
            return;
        }// end function

        private function updateSize() : void
        {
            setContentSize(-2, 0, this._width, this._height);
            var _loc_1:int = 0;
            var _loc_2:int = 10;
            while (_loc_1 < 3)
            {
                
                _loc_2 = _loc_2 - 1;
                _loc_1 = Math.floor((this._width - 8) / (ShopGrid.ITEM_WIDTH + _loc_2));
            }
            grid.span = _loc_1;
            grid.setSpacing(_loc_2, 10);
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            this._width = param1 + 5;
            this.updateSize();
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            this._height = param1;
            this.updateSize();
            return;
        }// end function

        override protected function handleShopItemMouse(event:ShopItemEvent) : void
        {
            var _loc_2:Number = NaN;
            var _loc_3:ShopItem = null;
            if (event.type == ShopItemEvent.MOUSE_OVER)
            {
                _loc_2 = 0;
                _loc_3 = event.target as ShopItem;
                if (scrollcontainer.y + _loc_3.y < 0)
                {
                    scrollbox.scrollY = _loc_3.y;
                }
                else if (scrollcontainer.y + _loc_3.y + ShopGrid.ITEM_HEIGHT + 26 > scrollbox.height)
                {
                    scrollbox.scrollY = _loc_3.y + ShopGrid.ITEM_HEIGHT - scrollbox.height + 1;
                    _loc_2 = -26;
                }
                mouseovercontainer.x = content.x;
                mouseovercontainer.y = content.y + scrollcontainer.y + _loc_2;
                mouseovercontainer.addChild(event.target as ShopItem);
            }
            else
            {
                grid.addChild(event.target as ShopItem);
            }
            return;
        }// end function

    }
}
