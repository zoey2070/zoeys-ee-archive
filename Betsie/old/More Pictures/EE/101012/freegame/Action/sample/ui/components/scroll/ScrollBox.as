package sample.ui.components.scroll
{
    import flash.display.*;
    import flash.events.*;
    import sample.ui.components.*;

    public class ScrollBox extends Box
    {
        private var _container:ScrollContainer;
        private var _mask:Sprite;
        private var _mouseoverlay:Sprite;
        private var _scrollX:Number = 0;
        private var _scrollY:Number = 0;
        private var _scrollMultiplier:Number = 1;
        private var _reversed:Boolean = false;
        private var _animated:Boolean = false;
        private var hscroll:ScrollBar;
        private var isfirst:Boolean = true;

        public function ScrollBox(param1:ScrollContainer = null)
        {
            var container:* = param1;
            this._mask = new Sprite();
            this._mouseoverlay = new Sprite();
            this.hscroll = new ScrollBar();
            this._container = container || new ScrollContainer();
            super.addChild(this._mouseoverlay);
            this._mouseoverlay.mouseEnabled = true;
            this._mouseoverlay.graphics.beginFill(0, 0);
            this._mouseoverlay.graphics.drawRect(0, 0, 100, 100);
            this._mouseoverlay.graphics.endFill();
            super.addChild(this._container);
            super.addChild(this._mask);
            super.addChild(this.hscroll);
            this._mask.graphics.beginFill(0, 1);
            this._mask.graphics.drawRect(0, 0, 100, 100);
            this._mask.graphics.endFill();
            this.hscroll.scroll(function (param1:Number) : void
            {
                scrollY = param1;
                return;
            }// end function
            );
            this._container.mask = this._mask;
            mouseEnabled = true;
            addEventListener(MouseEvent.MOUSE_WHEEL, this.handleScrollWheel);
            return;
        }// end function

        public function set scrollMultiplier(param1:Number) : void
        {
            this._scrollMultiplier = param1;
            return;
        }// end function

        private function handleScrollWheel(event:MouseEvent) : void
        {
            this.scrollY = this.scrollY - event.delta * this._scrollMultiplier;
            event.preventDefault();
            event.stopImmediatePropagation();
            event.stopPropagation();
            return;
        }// end function

        public function reverse() : ScrollBox
        {
            this._reversed = !this._reversed;
            return this;
        }// end function

        public function animated() : ScrollBox
        {
            this._animated = !this._animated;
            return this;
        }// end function

        override public function add(... args) : Box
        {
            args = null;
            for each (args in args)
            {
                
                this._container.addChild(args);
            }
            this.redraw();
            return this;
        }// end function

        public function set scrollX(param1:Number) : void
        {
            this._scrollX = param1;
            this.redraw();
            return;
        }// end function

        public function set scrollY(param1:Number) : void
        {
            if (this._scrollY != param1)
            {
                this._scrollY = param1;
                this.redraw();
                this.hscroll.scrollValue = param1;
            }
            return;
        }// end function

        public function scrollPixelsY(param1:Number) : void
        {
            this.hscroll.refresh();
            return;
        }// end function

        public function get scrollWidth() : Number
        {
            return this._container.width - this._mask.width;
        }// end function

        public function get scrollHeight() : Number
        {
            return this._container.height - this._mask.height;
        }// end function

        public function get scrollX() : Number
        {
            return this._scrollX;
        }// end function

        public function get scrollY() : Number
        {
            return this._scrollY;
        }// end function

        override public function get width() : Number
        {
            return _width;
        }// end function

        override public function get height() : Number
        {
            return _height;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            return this._container.addChild(param1);
        }// end function

        override public function removeChild(param1:DisplayObject) : DisplayObject
        {
            return this._container.removeChild(param1);
        }// end function

        public function refresh() : void
        {
            this.redraw();
            return;
        }// end function

        override protected function redraw() : void
        {
            var _loc_2:int = 0;
            var _loc_3:DisplayObject = null;
            var _loc_4:int = 0;
            var _loc_5:DisplayObject = null;
            var _loc_6:int = 0;
            var _loc_7:DisplayObject = null;
            if (_height == 0)
            {
                return;
            }
            var _loc_1:* = _width;
            _width = _width - 13;
            this.hscroll.visible = true;
            this.hscroll.scrollViewable = _height;
            this.hscroll.scrollSize = this._container.height + (_top || 0) + (_bottom || 0);
            if (dirty)
            {
                _loc_2 = 0;
                while (_loc_2 < numChildren)
                {
                    
                    _loc_3 = getChildAt(_loc_2);
                    _loc_3.width = rwidth - borderWidth;
                    _loc_3.height = rheight - borderHeight;
                    _loc_2++;
                }
            }
            if (this._container.height > _height)
            {
                this.hscroll.focus();
                _loc_4 = 0;
                while (_loc_4 < numChildren)
                {
                    
                    _loc_5 = getChildAt(_loc_4);
                    _loc_5.width = rwidth - borderWidth;
                    _loc_5.height = rheight - borderHeight;
                    _loc_4++;
                }
            }
            else
            {
                this.hscroll.blur();
                _width = _width + 13;
                _loc_6 = 0;
                while (_loc_6 < numChildren)
                {
                    
                    _loc_7 = getChildAt(_loc_6);
                    _loc_7.width = rwidth - borderWidth;
                    _loc_7.height = rheight - borderHeight;
                    _loc_6++;
                }
            }
            this._scrollX = Math.max(Math.min(this._scrollX, this.scrollWidth), 0);
            this._scrollY = Math.max(Math.min(this._scrollY, this.scrollHeight), 0);
            this._container.x = -this._scrollX;
            if (this._reversed && this._container.height < _height)
            {
                this.setContainerY(_height - this._container.height);
            }
            else
            {
                this.setContainerY(-this._scrollY + 1);
            }
            this.hscroll.x = _width + 1;
            this.hscroll.y = -1;
            this.hscroll.height = Math.ceil(_height) + 1;
            _width = _loc_1;
            dirty = false;
            this.hscroll.refresh();
            return;
        }// end function

        private function setContainerY(param1:Number) : void
        {
            this._container.y = param1;
            this.isfirst = false;
            return;
        }// end function

    }
}
