package ui.shop
{
    import flash.events.*;
    import flash.text.*;
    import gameanalytics.*;

    public class ShopBar extends assets_shopbar
    {
        private var mainshop:MainShop;

        public function ShopBar()
        {
            shop.visible = false;
            shopbtn.buttonMode = true;
            this.mainshop = new MainShop();
            this.mainshop.x = 10;
            this.mainshop.y = -21;
            shop.addChild(this.mainshop);
            energy.timetonext.autoSize = TextFieldAutoSize.LEFT;
            energy.energy.autoSize = TextFieldAutoSize.LEFT;
            gem.gems.autoSize = TextFieldAutoSize.LEFT;
            logout_btn.tf.text = Global.player_is_guest ? (" Close") : ("Logout");
            logout_btn.visible = !(Global.playing_on_kongregate || Global.playing_on_armorgames || Global.playing_on_faceboook);
            logout_btn.mouseChildren = false;
            logout_btn.mouseEnabled = true;
            logout_btn.buttonMode = true;
            logout_btn.addEventListener(MouseEvent.CLICK, this.handleLogoutButton, false, 0, true);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage, false, 0, true);
            return;
        }// end function

        protected function handleLogoutButton(event:MouseEvent) : void
        {
            var _loc_2:* = new NavigationEvent(NavigationEvent.LOGOUT, true, false);
            dispatchEvent(_loc_2);
            return;
        }// end function

        public function resize() : void
        {
            bg.width = Global.width;
            shopbtn.x = 15;
            energy.x = shopbtn.x + 98 + 13 >> 0;
            divider_1.x = energy.x + energy.width + 10;
            gem.x = divider_1.x + 12 >> 0;
            divider_2.x = gem.x + gem.width + 10;
            newsbtn.x = divider_2.x + 13;
            logout_btn.x = bg.width - logout_btn.width - 15;
            return;
        }// end function

        protected function handleAddedToStage(event:Event) : void
        {
            var event:* = event;
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage, false, 0, true);
            gem.addEventListener(MouseEvent.CLICK, function () : void
            {
                Shop.getMoreGems();
                return;
            }// end function
            );
            this.refreshTopBar();
            shopbtn.newitem.visible = !Shop.hasSeenNewest();
            shopbtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                shop.visible = !shop.visible;
                if (shop.visible)
                {
                    Global.tracker.trackPageview("/shop");
                    Global.tracker.trackUserEvent("shop");
                    GameAnalytics.newEvent(EventCategory.DESIGN, {event_id:"Shop:Open"});
                    shopbtn.newitem.visible = false;
                    Shop.setSeenNewest();
                }
                return;
            }// end function
            );
            addEventListener(Event.ENTER_FRAME, this.handleEnterFrame, false, 0, true);
            stage.addEventListener(ShopEvent.OPEN_MAINSHOP, this.handleOpenMainShopRequest, false, 0, true);
            this.resize();
            return;
        }// end function

        protected function handleOpenMainShopRequest(event:Event) : void
        {
            this.openShop();
            return;
        }// end function

        private function openShop() : void
        {
            shop.visible = true;
            return;
        }// end function

        protected function handleRemovedFromStage(event:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
            return;
        }// end function

        protected function handleEnterFrame(event:Event) : void
        {
            this.refreshTopBar();
            return;
        }// end function

        public function refreshTopBar() : void
        {
            if (!Shop.isInitiallyRefreshed())
            {
                return;
            }
            if (!Global.player_is_guest)
            {
                gem.gems.text = "Gems: " + Shop.gems;
                gem.gemsbtn.x = gem.gems.x + gem.gems.textWidth + 15;
                energy.energy.text = "Energy: " + Shop.energy + "/" + Shop.totalEnergy;
                energy.timetonext.text = "More in: " + Shop.prettyTimeToNext;
                energy.timetonext.visible = Shop.energy != Shop.totalEnergy;
                energy.energy.y = energy.timetonext.visible ? (0) : (5);
            }
            else
            {
                gem.gems.text = "Gems: 0";
                energy.energy.text = "Energy: 0/200";
                energy.timetonext.visible = false;
                energy.energy.y = 5;
            }
            this.resize();
            return;
        }// end function

    }
}
