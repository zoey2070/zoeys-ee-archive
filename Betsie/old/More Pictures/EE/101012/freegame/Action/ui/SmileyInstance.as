package ui
{
    import flash.display.*;
    import flash.events.*;
    import items.*;
    import ui2.*;

    public class SmileyInstance extends ui2smileyinstance
    {
        public var item:ItemSmiley;

        public function SmileyInstance(param1:ItemSmiley, param2:UI2)
        {
            var sp:Sprite;
            var item:* = param1;
            var ss:* = param2;
            this.item = item;
            var bm:* = new Bitmap(item.bmd);
            sp = new Sprite();
            sp.addChild(bm);
            sp.buttonMode = true;
            sp.useHandCursor = true;
            addChild(sp);
            sp.addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                ss.setSelectedSmiley(item.id);
                return;
            }// end function
            );
            sp.addEventListener(MouseEvent.MOUSE_UP, function () : void
            {
                ss.setSelectedSmiley(item.id);
                return;
            }// end function
            );
            return;
        }// end function

    }
}
