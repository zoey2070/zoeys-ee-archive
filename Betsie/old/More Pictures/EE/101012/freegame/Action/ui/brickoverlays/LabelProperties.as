package ui.brickoverlays
{
    import flash.events.*;
    import flash.text.*;

    public class LabelProperties extends PropertiesBackground
    {

        public function LabelProperties()
        {
            var tf:TextField;
            tf = new TextField();
            var tff:* = new TextFormat("system", 12, 16777215);
            tf.defaultTextFormat = tff;
            tf.type = TextFieldType.INPUT;
            tf.embedFonts = true;
            tf.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            tf.addEventListener(Event.CHANGE, function () : void
            {
                Global.default_label_text = tf.text;
                return;
            }// end function
            );
            tf.width = 324 - 20;
            tf.x = -150 - 5;
            tf.y = -34 - 10 + 2;
            tf.text = Global.default_label_text;
            tf.border = true;
            tf.borderColor = 16777215;
            tf.background = true;
            tf.backgroundColor = 3355443;
            tf.height = tf.textHeight + 10;
            addChild(tf);
            setSize(325, 50);
            tf.addEventListener(FocusEvent.FOCUS_IN, function (event:Event) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            return;
        }// end function

    }
}
