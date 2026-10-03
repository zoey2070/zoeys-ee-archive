package ui.brickoverlays
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import items.*;

    public class DrumProperties extends PropertiesBackground
    {
        private var selectors:Vector.<Sprite>;
        static var drumBM:Class = DrumProperties_drumBM;
        private static var drum:Bitmap = new drumBM();
        private static var mark:Sprite = new Sprite();

        public function DrumProperties()
        {
            this.selectors = new Vector.<Sprite>;
            addChild(drum);
            drum.x = -128;
            drum.y = -70;
            mark.graphics.clear();
            mark.graphics.beginFill(16711680, 0.5);
            mark.graphics.drawCircle(0, 0, 4);
            mark.graphics.endFill();
            mark.mouseEnabled = false;
            var _loc_1:* = -128 - 41;
            var _loc_2:* = _loc_1 + 42;
            _loc_1 = _loc_1 + 42;
            addChild(this.createDrumBox(0, _loc_2));
            var _loc_2:* = _loc_1 + 43;
            _loc_1 = _loc_1 + 43;
            addChild(this.createDrumBox(2, _loc_2));
            var _loc_2:* = _loc_1 + 42;
            _loc_1 = _loc_1 + 42;
            addChild(this.createDrumBox(4, _loc_2));
            var _loc_2:* = _loc_1 + 42;
            _loc_1 = _loc_1 + 42;
            addChild(this.createDrumBox(7, _loc_2));
            var _loc_2:* = _loc_1 + 43;
            _loc_1 = _loc_1 + 43;
            addChild(this.createDrumBox(8, _loc_2));
            var _loc_2:* = _loc_1 + 42;
            _loc_1 = _loc_1 + 42;
            addChild(this.createDrumBox(9, _loc_2));
            _loc_1 = -128 - 15 + 7;
            var _loc_2:* = _loc_1 + 15;
            _loc_1 = _loc_1 + 15;
            addChild(this.createDrumSelector(0, _loc_2));
            var _loc_2:* = _loc_1 + 16;
            _loc_1 = _loc_1 + 16;
            addChild(this.createDrumSelector(1, _loc_2));
            var _loc_2:* = _loc_1 + 27;
            _loc_1 = _loc_1 + 27;
            addChild(this.createDrumSelector(2, _loc_2));
            var _loc_2:* = _loc_1 + 16;
            _loc_1 = _loc_1 + 16;
            addChild(this.createDrumSelector(3, _loc_2));
            var _loc_2:* = _loc_1 + 22;
            _loc_1 = _loc_1 + 22;
            addChild(this.createDrumSelector(4, _loc_2));
            var _loc_2:* = _loc_1 + 13;
            _loc_1 = _loc_1 + 13;
            addChild(this.createDrumSelector(5, _loc_2));
            var _loc_2:* = _loc_1 + 13;
            _loc_1 = _loc_1 + 13;
            addChild(this.createDrumSelector(6, _loc_2));
            var _loc_2:* = _loc_1 + 29;
            _loc_1 = _loc_1 + 29;
            addChild(this.createDrumSelector(7, _loc_2));
            var _loc_2:* = _loc_1 + 42;
            _loc_1 = _loc_1 + 42;
            addChild(this.createDrumSelector(8, _loc_2));
            var _loc_2:* = _loc_1 + 44;
            _loc_1 = _loc_1 + 44;
            addChild(this.createDrumSelector(9, _loc_2));
            setSize(260, 72);
            this.filters = [new DropShadowFilter(0, 0, 0, 1, 6, 6, 2)];
            addChild(mark);
            return;
        }// end function

        private function createDrumBox(param1:int, param2:int) : Sprite
        {
            var id:* = param1;
            var xx:* = param2;
            var s:* = new Sprite();
            s.x = xx;
            s.y = -70;
            s.graphics.beginFill(16711680, 0);
            s.graphics.drawRect(0, 0, 42, 42);
            s.graphics.endFill();
            s.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Global.play_sounds)
                {
                    ItemManager.drumSounds[id].play();
                }
                selectSound(id);
                return;
            }// end function
            );
            return s;
        }// end function

        private function createDrumSelector(param1:int, param2:int) : Sprite
        {
            var id:* = param1;
            var xx:* = param2;
            var s:* = new Sprite();
            s.x = xx;
            s.y = -31;
            s.graphics.beginFill(255, 0);
            s.graphics.drawRect(0, 0, 12, 11);
            s.graphics.endFill();
            this.selectors[id] = s;
            s.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Global.play_sounds)
                {
                    ItemManager.drumSounds[id].play();
                }
                selectSound(id);
                return;
            }// end function
            );
            if (id == Global.drumOffset)
            {
                this.selectSound(id);
            }
            return s;
        }// end function

        private function selectSound(param1:int) : void
        {
            Global.drumOffset = param1;
            mark.x = this.selectors[param1].x + 6;
            mark.y = this.selectors[param1].y + 5.5;
            return;
        }// end function

    }
}
