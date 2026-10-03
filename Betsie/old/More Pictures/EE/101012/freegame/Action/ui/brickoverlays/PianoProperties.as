package ui.brickoverlays
{
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import items.*;

    public class PianoProperties extends PropertiesBackground
    {
        static var pianoBM:Class = PianoProperties_pianoBM;
        private static var piano:Bitmap = new pianoBM();
        private static var mark:Sprite = new Sprite();

        public function PianoProperties()
        {
            addChild(piano);
            piano.x = -128;
            piano.y = -70;
            mark.graphics.clear();
            mark.graphics.beginFill(16711680, 0.5);
            mark.graphics.drawCircle(0, 0, 4);
            mark.graphics.endFill();
            mark.mouseEnabled = false;
            var _loc_1:* = -128 - 17;
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(0, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(2, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(4, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(5, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(7, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(9, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(11, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(12, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(14, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(16, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(17, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(19, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(21, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(23, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createWhiteKey(24, _loc_2));
            _loc_1 = -128 + 12 - 17;
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(1, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(3, _loc_2));
            _loc_1 = _loc_1 + 17;
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(6, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(8, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(10, _loc_2));
            _loc_1 = _loc_1 + 17;
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(13, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(15, _loc_2));
            _loc_1 = _loc_1 + 17;
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(18, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(20, _loc_2));
            var _loc_2:* = _loc_1 + 17;
            _loc_1 = _loc_1 + 17;
            addChild(this.createBlackKey(22, _loc_2));
            _loc_1 = _loc_1 + 17;
            setSize(260, 72);
            this.filters = [new DropShadowFilter(0, 0, 0, 1, 6, 6, 2)];
            addChild(mark);
            return;
        }// end function

        private function createWhiteKey(param1:int, param2:int) : Sprite
        {
            var s:Sprite;
            var id:* = param1;
            var xx:* = param2;
            s = new Sprite();
            s.x = xx;
            s.y = -70;
            if (id == 0 && Global.pianoOffset == 0)
            {
                mark.x = s.x + 17 / 2;
                mark.y = s.y + 30;
            }
            s.graphics.beginFill(16711680, 0);
            s.graphics.drawRect(0, 0, 17, 39);
            s.graphics.endFill();
            s.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                Global.pianoOffset = id;
                if (Global.play_sounds)
                {
                    ItemManager.pianoSounds[id].play();
                }
                mark.x = s.x + 17 / 2;
                mark.y = s.y + 30;
                return;
            }// end function
            );
            return s;
        }// end function

        private function createBlackKey(param1:int, param2:int) : Sprite
        {
            var s:Sprite;
            var id:* = param1;
            var xx:* = param2;
            s = new Sprite();
            s.x = xx;
            s.y = -75;
            s.graphics.beginFill(255, 0);
            s.graphics.drawRect(0, 0, 9, 25);
            s.graphics.endFill();
            s.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                Global.pianoOffset = id;
                if (Global.play_sounds)
                {
                    ItemManager.pianoSounds[id].play();
                }
                mark.x = s.x + 5;
                mark.y = s.y + 20;
                return;
            }// end function
            );
            return s;
        }// end function

    }
}
