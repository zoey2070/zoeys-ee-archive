package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import ui2.*;

    public class BrickSelector extends ui2brickselector
    {
        private var packages:Array;
        private var basiswidth:int;
        private var masker:Sprite;
        private var bg:Sprite;
        private var tabAction:tabAction;
        private var tabBackground:tabBackground;
        private var tabBlocks:tabBlocks;
        private var tabDecorative:tabDecorative;
        private var tabs:Array;
        private var tabContainers:Array;
        private var selectedTabNum:int;
        private var uix:UI2;

        public function BrickSelector(param1:UI2)
        {
            var uix:* = param1;
            this.packages = [];
            this.basiswidth = Global.fullWidth;
            this.masker = new Sprite();
            this.bg = new Sprite();
            this.tabAction = new tabAction();
            this.tabBackground = new tabBackground();
            this.tabBlocks = new tabBlocks();
            this.tabDecorative = new tabDecorative();
            this.tabs = [this.tabBlocks, this.tabAction, this.tabDecorative, this.tabBackground];
            this.tabContainers = [];
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            this.uix = uix;
            var i:int;
            while (i < this.tabs.length)
            {
                
                addChild(this.tabs[i]);
                this.tabs[i].x = 5 + i * 120;
                this.tabs[i].y = -22;
                this.tabs[i].mouseEnabled = true;
                this.tabs[i].buttonMode = true;
                this.tabs[i].gotoAndStop(2);
                i = (i + 1);
            }
            addChild(this.bg);
            i;
            while (i < this.tabs.length)
            {
                
                this.tabContainers[i] = new MovieClip();
                addChild(this.tabContainers[i]);
                i = (i + 1);
            }
            this.setActiveTab(0);
            this.tabBlocks.addEventListener(MouseEvent.CLICK, function () : void
            {
                setActiveTab(0);
                return;
            }// end function
            );
            this.tabAction.addEventListener(MouseEvent.CLICK, function () : void
            {
                setActiveTab(1);
                return;
            }// end function
            );
            this.tabDecorative.addEventListener(MouseEvent.CLICK, function () : void
            {
                setActiveTab(2);
                return;
            }// end function
            );
            this.tabBackground.addEventListener(MouseEvent.CLICK, function () : void
            {
                setActiveTab(3);
                return;
            }// end function
            );
            var shadow:* = new DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3);
            var _loc_3:* = [shadow];
            this.tabBackground.filters = [shadow];
            var _loc_3:* = _loc_3;
            this.tabDecorative.filters = _loc_3;
            var _loc_3:* = _loc_3;
            this.tabAction.filters = _loc_3;
            var _loc_3:* = _loc_3;
            this.tabBlocks.filters = _loc_3;
            this.bg.filters = _loc_3;
            return;
        }// end function

        public function setActiveTab(param1:int) : void
        {
            this.uix.hideAllProperties();
            this.selectedTabNum = 0;
            var _loc_2:int = 0;
            while (_loc_2 < this.tabs.length)
            {
                
                this.tabs[_loc_2].gotoAndStop(2);
                this.tabContainers[_loc_2].visible = false;
                _loc_2++;
            }
            this.tabs[param1].gotoAndStop(1);
            this.tabContainers[param1].visible = true;
            return;
        }// end function

        public function addPackage(param1:BrickPackage, param2:int) : void
        {
            this.packages.push(param1);
            this.tabContainers[param2].addChild(param1);
            return;
        }// end function

        public function removeAllPackages() : void
        {
            var _loc_1:* = this.packages.pop();
            var _loc_2:int = 0;
            while (_loc_2 < this.tabContainers.length)
            {
                
                while (this.tabContainers[_loc_2].numChildren >= 1)
                {
                    
                    this.tabContainers[_loc_2].removeChildAt(0);
                }
                _loc_2++;
            }
            while (_loc_1)
            {
                
                _loc_1 = this.packages.pop();
            }
            return;
        }// end function

        public function getPosition(param1:int) : Point
        {
            var _loc_2:Point = null;
            var _loc_3:int = 0;
            while (_loc_3 < this.packages.length)
            {
                
                _loc_2 = this.packages[_loc_3].getPosition(param1) || _loc_2;
                _loc_3++;
            }
            return _loc_2;
        }// end function

        public function setSelected(param1:int) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < this.packages.length)
            {
                
                this.packages[_loc_2].setSelected(param1);
                _loc_2++;
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return this.basiswidth;
        }// end function

        public function redraw() : void
        {
            var _loc_7:txtNoTabItems = null;
            var _loc_8:int = 0;
            var _loc_9:DisplayObject = null;
            var _loc_1:int = 5;
            var _loc_2:int = 5;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            while (_loc_4 < this.tabContainers.length)
            {
                
                var _loc_10:int = 5;
                _loc_2 = 5;
                _loc_1 = _loc_10;
                if (this.tabContainers[_loc_4].numChildren == 0)
                {
                    _loc_7 = new txtNoTabItems();
                    if (Global.player_is_guest)
                    {
                        _loc_7.gotoAndStop(2);
                    }
                    else
                    {
                        _loc_7.gotoAndStop(1);
                    }
                    this.tabContainers[_loc_4].addChild(_loc_7);
                }
                else
                {
                    _loc_8 = 0;
                    while (_loc_8 < this.tabContainers[_loc_4].numChildren)
                    {
                        
                        _loc_9 = this.tabContainers[_loc_4].getChildAt(_loc_8);
                        if (_loc_1 + _loc_9.width + 5 >= this.basiswidth)
                        {
                            _loc_1 = 5;
                            _loc_2 = _loc_2 + 30;
                        }
                        _loc_9.x = _loc_1;
                        _loc_9.y = _loc_2;
                        _loc_1 = _loc_1 + (_loc_9.width + 5);
                        if (_loc_2 > _loc_3)
                        {
                            _loc_3 = _loc_2;
                        }
                        _loc_8++;
                    }
                }
                _loc_4++;
            }
            _loc_3 = _loc_3 + 30;
            var _loc_5:* = this.bg.graphics;
            this.bg.graphics.clear();
            _loc_5.lineStyle(1, 8092539, 1);
            _loc_5.beginFill(3289649, 0.85);
            _loc_5.drawRect(0, 0, this.basiswidth, _loc_3 + 5);
            this.y = -_loc_3 - 35;
            var _loc_6:* = this.masker.graphics;
            this.masker.graphics.clear();
            _loc_6.beginFill(16777215, 1);
            _loc_6.drawRect(-5, -5, (this.basiswidth + 1) + 10, _loc_3 + 10);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            this.redraw();
            return;
        }// end function

    }
}
