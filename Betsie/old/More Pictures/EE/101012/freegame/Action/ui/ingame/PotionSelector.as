package ui.ingame
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.utils.*;
    import ui.*;
    import ui2.*;

    public class PotionSelector extends Sprite
    {
        private var potions:Array;
        private var basiswidth:int = 153;
        private var masker:Sprite;
        private var bg:Sprite;
        private var selected_num:int = 0;
        private var selected:Bitmap;
        private var no_potions:MovieClip;
        private var hover:PotionInstance;
        private var hovertimer:uint;
        private var hoverlabel:PotionHoverLabel;

        public function PotionSelector()
        {
            this.potions = [];
            this.masker = new Sprite();
            this.bg = new Sprite();
            this.selected = new Bitmap(new ui2selector());
            this.no_potions = new ui2nopotions();
            addEventListener(Event.ADDED_TO_STAGE, this.handleAttach);
            addChild(this.bg);
            this.no_potions.x = 12;
            this.no_potions.y = 8;
            addChild(this.no_potions);
            this.bg.filters = [new DropShadowFilter(0, 45, 0, 1, 4, 4, 1, 3)];
            this.hoverlabel = new PotionHoverLabel();
            this.hoverlabel.visible = false;
            addEventListener(MouseEvent.MOUSE_OVER, this.handleMouse, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.handleMouse, false, 0, true);
            addEventListener(MouseEvent.MOUSE_MOVE, this.handleMouseMove, false, 0, true);
            return;
        }// end function

        protected function handleMouseMove(event:MouseEvent = null) : void
        {
            if (this.hoverlabel.visible)
            {
                this.hoverlabel.x = mouseX - this.hoverlabel.width / 2;
                this.hoverlabel.y = mouseY - this.hoverlabel.height - 5;
            }
            return;
        }// end function

        protected function handleMouse(event:MouseEvent) : void
        {
            if (event.target is PotionInstance)
            {
                if (event.type == MouseEvent.MOUSE_OVER)
                {
                    this.hover = event.target as PotionInstance;
                    this.hovertimer = setTimeout(this.showHoverLabel, 1000);
                }
                else
                {
                    this.hoverlabel.visible = false;
                    clearInterval(this.hovertimer);
                }
            }
            return;
        }// end function

        public function showHoverLabel() : void
        {
            addChild(this.hoverlabel);
            this.hoverlabel.draw(this.hover.item);
            this.hoverlabel.visible = true;
            this.handleMouseMove();
            return;
        }// end function

        public function clearPotions() : void
        {
            var _loc_1:int = 0;
            while (_loc_1 < this.potions.length)
            {
                
                if (this.potions[_loc_1] != null && contains(this.potions[_loc_1]))
                {
                    removeChild(this.potions[_loc_1]);
                }
                _loc_1++;
            }
            this.potions = [];
            return;
        }// end function

        public function addPotion(param1:PotionInstance) : void
        {
            this.potions[param1.item.id] = param1;
            addChild(param1);
            this.redraw();
            return;
        }// end function

        override public function get width() : Number
        {
            return this.potions.length > 0 ? ((this.potions.length - 1) * 18 + 10) : (this.basiswidth);
        }// end function

        public function setSelectedPotion(param1:int) : void
        {
            if (this.potions[param1] != null)
            {
                addChild(this.selected);
                this.selected_num = param1;
                this.selected.x = this.potions[param1].x;
                this.selected.y = this.potions[param1].y + 5;
            }
            return;
        }// end function

        public function clearSelected() : void
        {
            if (contains(this.selected))
            {
                removeChild(this.selected);
            }
            return;
        }// end function

        public function getSelectedPotion() : int
        {
            return this.selected_num;
        }// end function

        private function redraw() : void
        {
            var _loc_1:int = 5;
            var _loc_2:int = 0;
            var _loc_3:int = 0;
            while (_loc_3 < this.potions.length)
            {
                
                if (this.potions[_loc_3])
                {
                    if (_loc_1 + this.potions[_loc_3].width + 5 >= this.basiswidth)
                    {
                        _loc_1 = 5;
                        _loc_2 = _loc_2 + 22;
                    }
                    this.potions[_loc_3].x = _loc_1;
                    this.potions[_loc_3].y = _loc_2;
                    _loc_1 = _loc_1 + (this.potions[_loc_3].width + 2);
                }
                _loc_3++;
            }
            this.no_potions.visible = this.potions.length == 0;
            _loc_2 = _loc_2 + 18;
            var _loc_4:* = this.bg.graphics;
            this.bg.graphics.clear();
            _loc_4.lineStyle(1, 8092539, 1);
            _loc_4.beginFill(3289649, 0.85);
            _loc_4.drawRect(0, 0, this.width, _loc_2 + 8);
            this.y = -_loc_2 - 38;
            var _loc_5:* = this.masker.graphics;
            this.masker.graphics.clear();
            _loc_5.beginFill(16777215, 1);
            _loc_5.drawRect(-5, -5, (this.width + 1) + 10, _loc_2 + 13);
            return;
        }// end function

        private function handleAttach(event:Event) : void
        {
            this.redraw();
            return;
        }// end function

    }
}
