package ui
{
    import blitter.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import items.*;

    public class PotionInstance extends Sprite
    {
        public var item:ItemPotion;

        public function PotionInstance(param1:ItemPotion, param2:int, param3:UI2)
        {
            var sp:Sprite;
            var item:* = param1;
            var amount:* = param2;
            var ss:* = param3;
            this.item = item;
            var textCount:* = new BlText(14, 18, 16777215, "right", "visitor");
            textCount.filters = [new GlowFilter(0, 1, 2, 2, 2, 3, false, false)];
            textCount.text = amount.toString();
            var bmd:* = item.bmd.clone();
            var m:* = new Matrix();
            m.translate(0, 13);
            bmd.draw(textCount.clone(), m);
            var bm:* = new Bitmap(bmd);
            sp = new Sprite();
            sp.addChild(bm);
            mouseChildren = false;
            mouseEnabled = amount > 0;
            buttonMode = amount > 0;
            useHandCursor = amount > 0;
            addEventListener(MouseEvent.MOUSE_DOWN, function () : void
            {
                ss.setSelectedPotion(item.id);
                return;
            }// end function
            );
            addEventListener(MouseEvent.MOUSE_UP, function () : void
            {
                ss.setSelectedPotion(item.id);
                return;
            }// end function
            );
            addChild(sp);
            return;
        }// end function

    }
}
