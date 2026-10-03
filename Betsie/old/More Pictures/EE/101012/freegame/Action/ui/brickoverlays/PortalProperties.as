package ui.brickoverlays
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import ui2.*;

    public class PortalProperties extends PropertiesBackground
    {

        public function PortalProperties()
        {
            var _loc_1:* = this.createPointScroller("ID of this portal:", "portal_id");
            _loc_1.y = -39 - 25;
            var _loc_2:* = this.createPointScroller("ID of the target portal:", "portal_target");
            _loc_2.y = -39;
            addChild(_loc_1);
            addChild(_loc_2);
            setSize(325, 75);
            return;
        }// end function

        private function createPointScroller(param1:String, param2:String) : Sprite
        {
            var tf:TextField;
            var inptf:TextField;
            var name:* = param1;
            var id:* = param2;
            var container:* = new Sprite();
            tf = new TextField();
            tf.embedFonts = true;
            tf.selectable = false;
            tf.sharpness = 100;
            tf.multiline = false;
            tf.wordWrap = false;
            var tff:* = new TextFormat("system", 12, 16777215);
            tf.defaultTextFormat = tff;
            tf.width = 324;
            tf.x = -150;
            tf.y = 0;
            tf.text = name;
            tf.height = tf.textHeight;
            container.addChild(tf);
            inptf = new TextField();
            inptf.selectable = false;
            inptf.sharpness = 100;
            inptf.multiline = false;
            inptf.borderColor = 16777215;
            inptf.backgroundColor = 11184810;
            inptf.background = true;
            inptf.border = true;
            var inptff:* = new TextFormat("Arial", 12, 0, null, null, null, null, null, TextFormatAlign.CENTER);
            inptf.defaultTextFormat = inptff;
            inptf.text = Bl.data[id];
            inptf.height = tf.height + 3;
            inptf.width = 25;
            inptf.y = 0;
            inptf.x = 130 - 30;
            var add:* = new ui2plusbtn();
            add.y = 9;
            add.x = 130 + 10;
            container.addChild(add);
            add.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Bl.data[id] < 99)
                {
                    var _loc_1:* = Bl.data;
                    var _loc_2:* = id;
                    var _loc_3:* = Bl.data[id] + 1;
                    _loc_1[_loc_2] = _loc_3;
                }
                inptf.text = Bl.data[id];
                return;
            }// end function
            );
            var sub:* = new ui2minusbtn();
            sub.y = 9;
            sub.x = 130 - 29 - 16;
            container.addChild(sub);
            sub.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                if (Bl.data[id] > 0)
                {
                    var _loc_1:* = Bl.data;
                    var _loc_2:* = id;
                    var _loc_3:* = Bl.data[id] - 1;
                    _loc_1[_loc_2] = _loc_3;
                }
                inptf.text = Bl.data[id];
                return;
            }// end function
            );
            container.addChild(inptf);
            return container;
        }// end function

    }
}
