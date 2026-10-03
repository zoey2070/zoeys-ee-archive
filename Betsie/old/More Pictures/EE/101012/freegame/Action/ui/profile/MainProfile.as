package ui.profile
{
    import flash.display.*;
    import flash.events.*;
    import sample.ui.components.*;
    import ui.*;
    import ui.shop.*;

    public class MainProfile extends asset_MainProfile
    {
        private var tabbar:TabBar;
        private var content:Box;
        private var myprofile:MyProfile;
        private var currentcontent:Sprite;
        private var myworlds:MyWorlds;
        private var myitems:MyItems;
        private var myfriends:MyFriends;
        private var myshop:MyShop;
        private var loadinglabel:Label;
        private static const TAB_SPACING:int = 4;
        private static const TAB_FRIENDS:int = 0;
        private static const TAB_WORLDS:int = 1;
        private static const TAB_ITEMS:int = 2;
        private static const TAB_MINISHOP:int = 3;

        public function MainProfile()
        {
            this.content = new Box();
            this.content.margin(10, 10, 10, 10);
            this.content.y = bg.y;
            this.myprofile = new MyProfile();
            addChild(this.myprofile);
            this.loadinglabel = new Label("Loading Content...", 12, "left", 16777215, false, "system");
            if (!Global.player_is_guest)
            {
                this.initTabs();
                this.showContent(TAB_MINISHOP);
                this.tabbar.setSelected(TAB_MINISHOP);
            }
            else
            {
                this.content.margin(10, 0, 0, 0);
                this.content.add(new RegisterAd());
            }
            addChild(this.content);
            return;
        }// end function

        private function initTabs() : void
        {
            this.tabbar = new TabBar();
            addChild(this.tabbar);
            this.tabbar.y = bg.y - 21;
            this.tabbar.spacing = TAB_SPACING;
            this.tabbar.addTab(TAB_FRIENDS, "Friends", Tab.ICON_SMILEY);
            this.tabbar.addTab(TAB_WORLDS, "Worlds", Tab.ICON_WORLD);
            this.tabbar.addTab(TAB_ITEMS, "Items", Tab.ICON_BOOK);
            this.tabbar.addTab(TAB_MINISHOP, "Shop", Tab.ICON_LIGHTNING);
            this.tabbar.addEventListener(MouseEvent.MOUSE_DOWN, this.handleMouseTab, false, 0, true);
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
            var id:* = param1;
            if (this.currentcontent != null && this.currentcontent.stage != null)
            {
                this.content.removeChild(this.currentcontent);
            }
            this.content.add(this.loadinglabel);
            switch(id)
            {
                case TAB_FRIENDS:
                {
                    if (!this.myfriends)
                    {
                        this.myfriends = new MyFriends();
                    }
                    this.myfriends.refresh(function () : void
            {
                onContentReady(myfriends);
                return;
            }// end function
            );
                    break;
                }
                case TAB_WORLDS:
                {
                    if (!this.myworlds)
                    {
                        this.myworlds = new MyWorlds();
                    }
                    this.onContentReady(this.myworlds);
                    break;
                }
                case TAB_ITEMS:
                {
                    if (!this.myitems)
                    {
                        this.myitems = new MyItems();
                    }
                    this.onContentReady(this.myitems);
                    break;
                }
                case TAB_MINISHOP:
                {
                    if (!this.myshop)
                    {
                        this.myshop = new MyShop();
                    }
                    this.onContentReady(this.myshop);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onContentReady(param1:Sprite) : void
        {
            if (this.currentcontent == null || this.currentcontent.stage == null)
            {
                this.content.removeChild(this.loadinglabel);
                this.currentcontent = param1;
                this.content.add(param1);
            }
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            var _loc_2:* = param1;
            bg_upper.width = param1;
            bg.width = _loc_2;
            this.myprofile.width = param1;
            this.myprofile.height = this.tabbar ? (this.tabbar.y) : (bg.y - 21);
            if (!Global.player_is_guest)
            {
                this.tabbar.width = param1;
            }
            this.content.width = bg.width;
            this.content.height = bg.height;
            return;
        }// end function

    }
}
