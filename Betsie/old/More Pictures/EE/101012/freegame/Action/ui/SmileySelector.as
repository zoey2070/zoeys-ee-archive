package ui
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import ui2.*;

    public class SmileySelector extends ui2smileyselector
    {
        private var smilies:Array;
        public var basiswidth:int = 153;
        private var masker:Sprite;
        private var bg:Sprite;
        private var selected:Bitmap;

        public function SmileySelector()
        {
            this.smilies = [];
            this.masker = new Sprite();
            this.bg = new Sprite();
            this.selected = new Bitmap(new ui2selector());
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addChild(this.bg);
            addChild(this.masker);
            this.mask = this.masker;
            this.bg.filters = [new DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3)];
            return;
        }// end function

        public function addSmiley(param1:SmileyInstance) : void
        {
            this.smilies[param1.item.id] = param1;
            addChild(param1);
            addChild(this.selected);
            this.redraw();
            return;
        }// end function

        override public function get width() : Number
        {
            return this.basiswidth;
        }// end function

        public function setSelectedSmiley(param1:int) : void
        {
            if (this.smilies[param1] == null)
            {
                param1 = 1;
            }
            this.selected.x = this.smilies[param1].x;
            this.selected.y = this.smilies[param1].y + 5;
            return;
        }// end function

        private function redraw() : void
        {
            var _loc_1:int = 5;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < this.smilies.length)
            {
                
                if (this.smilies[_loc_3])
                {
                    if (_loc_1 + this.smilies[_loc_3].width + 5 >= this.basiswidth)
                    {
                        _loc_1 = 5;
                        _loc_2 = _loc_2 + 22;
                    }
                    this.smilies[_loc_3].x = _loc_1;
                    this.smilies[_loc_3].y = _loc_2;
                    _loc_1 = _loc_1 + (this.smilies[_loc_3].width + 2);
                }
                _loc_3++;
            }
            _loc_2 = _loc_2 + 18;
            var _loc_4:* = this.bg.graphics;
            this.bg.graphics.clear();
            _loc_4.lineStyle(1, 8092539, 1);
            _loc_4.beginFill(3289649, 0.85);
            _loc_4.drawRect(0, 0, this.basiswidth, _loc_2 + 8);
            this.y = -_loc_2 - 38;
            var _loc_5:* = this.masker.graphics;
            this.masker.graphics.clear();
            _loc_5.beginFill(16777215, 1);
            _loc_5.drawRect(-5, -5, (this.basiswidth + 1) + 10, _loc_2 + 13);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            this.redraw();
            return;
        }// end function

    }
}
