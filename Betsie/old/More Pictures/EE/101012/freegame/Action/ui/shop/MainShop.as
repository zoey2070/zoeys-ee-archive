package ui.shop
{
    import __AS3__.vec.*;
    import data.*;
    import flash.events.*;
    import ui.*;

    public class MainShop extends BaseShop
    {
        private var tabbar:TabBar;
        private var current_content_id:int;
        private static const ALL:int = -1;
        private static const TAB_FEATURED:int = 0;
        private static const TAB_SMILEYS:int = 1;
        private static const TAB_BLOCKS:int = 2;
        private static const TAB_WORLDS:int = 3;
        private static const TAB_CLASSIC:int = 4;
        private static const TAB_POTION:int = 5;

        public function MainShop()
        {
            super(6);
            setContentSize(10, 40, 590, 369);
            this.tabbar = new TabBar();
            addChildAt(this.tabbar, 0);
            this.tabbar.spacing = 4;
            this.tabbar.addTab(TAB_FEATURED, "Featured", Tab.ICON_CROWN);
            this.tabbar.addTab(TAB_SMILEYS, "Smileys", Tab.ICON_SMILEY);
            this.tabbar.addTab(TAB_BLOCKS, "Blocks", Tab.ICON_BRICK);
            this.tabbar.addTab(TAB_WORLDS, "Worlds", Tab.ICON_WORLD);
            if (Global.player_is_beta_member)
            {
                this.tabbar.addTab(TAB_POTION, "Potions", Tab.ICON_POTION);
            }
            this.tabbar.addTab(TAB_CLASSIC, "Classic", Tab.ICON_BOOK);
            this.tabbar.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseTab, false, 0, true);
            this.tabbar.setSelected(0);
            this.tabbar.width = 600;
            this.showContent(0);
            return;
        }// end function

        protected function handleMouseTab(event:MouseEvent) : void
        {
            var _loc_2:* = event.target as Tab;
            this.showContent(_loc_2.id);
            return;
        }// end function

        private function showContent(param1:int) : void
        {
            if (!Shop.isInitiallyRefreshed())
            {
                return;
            }
            refreshShopItems();
            this.current_content_id = param1;
            var _loc_2:* = new Vector.<ShopItemData>;
            var _loc_3:int = 0;
            while (_loc_3 < all_items.length)
            {
                
                switch(param1)
                {
                    case -1:
                    {
                        _loc_2.push(all_items[_loc_3]);
                        break;
                    }
                    case TAB_FEATURED:
                    {
                        if (all_items[_loc_3].isFeatured)
                        {
                            _loc_2.push(all_items[_loc_3]);
                        }
                        break;
                    }
                    case TAB_SMILEYS:
                    {
                        if (all_items[_loc_3].type == ShopItemData.TYPE_SMILEY && !all_items[_loc_3].isClassic)
                        {
                            _loc_2.push(all_items[_loc_3]);
                        }
                        break;
                    }
                    case TAB_BLOCKS:
                    {
                        if (all_items[_loc_3].type == ShopItemData.TYPE_BRICK && !all_items[_loc_3].isClassic)
                        {
                            _loc_2.push(all_items[_loc_3]);
                        }
                        break;
                    }
                    case TAB_WORLDS:
                    {
                        if (all_items[_loc_3].type == ShopItemData.TYPE_WORLD && !all_items[_loc_3].isClassic)
                        {
                            _loc_2.push(all_items[_loc_3]);
                        }
                        break;
                    }
                    case TAB_POTION:
                    {
                        if (all_items[_loc_3].type == ShopItemData.TYPE_POTION && !all_items[_loc_3].isClassic)
                        {
                            _loc_2.push(all_items[_loc_3]);
                        }
                        break;
                    }
                    case TAB_CLASSIC:
                    {
                        if (all_items[_loc_3].isClassic)
                        {
                            _loc_2.push(all_items[_loc_3]);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_3++;
            }
            showItems(_loc_2);
            return;
        }// end function

    }
}
