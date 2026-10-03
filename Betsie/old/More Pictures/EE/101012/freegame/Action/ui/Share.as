package ui
{
    import flash.events.*;

    public class Share extends asset_share
    {

        public function Share(param1:String, param2:String)
        {
            var title:* = param1;
            var dtext:* = param2;
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
            return;
        }// end function

        private function stopEvent(event:Event) : void
        {
            return;
        }// end function

        private function close(event:Event = null) : void
        {
            if (stage)
            {
                stage.focus = Global.base;
            }
            this.parent.removeChild(this);
            return;
        }// end function

    }
}
