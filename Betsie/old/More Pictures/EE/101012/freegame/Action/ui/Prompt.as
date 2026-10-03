package ui
{
    import flash.events.*;

    public class Prompt extends asset_prompt
    {

        public function Prompt(param1:String, param2:String, param3:Function)
        {
            var title:* = param1;
            var dtext:* = param2;
            var callback:* = param3;
            this.addEventListener(MouseEvent.MOUSE_DOWN, function (event:MouseEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            this.addEventListener(KeyboardEvent.KEY_DOWN, function (event:KeyboardEvent) : void
            {
                event.preventDefault();
                event.stopImmediatePropagation();
                event.stopPropagation();
                return;
            }// end function
            );
            closebtn.addEventListener(MouseEvent.CLICK, this.close);
            headline.text = title;
            inputvar.text = dtext;
            inputvar.restrict = "0-9 A-Za-z";
            inputvar.maxChars = 20;
            savebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                if (inputvar.length >= 4)
                {
                    callback(inputvar.text);
                    close();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function close(event:Event = null) : void
        {
            this.parent.removeChild(this);
            return;
        }// end function

    }
}
