package ui.ingame
{
    import blitter.*;
    import flash.display.*;
    import items.*;

    public class PotionHoverLabel extends Sprite
    {

        public function PotionHoverLabel()
        {
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public function draw(param1:ItemPotion) : void
        {
            while (numChildren > 0)
            {
                
                removeChildAt(0);
            }
            var _loc_2:* = new BlText(14, 120, 16777215, "left", "visitor");
            _loc_2.text = param1.description;
            var _loc_3:* = new Bitmap(_loc_2.clone());
            _loc_3.x = 4;
            _loc_3.y = 3;
            addChild(_loc_3);
            graphics.clear();
            graphics.lineStyle(1, 8092539, 1);
            graphics.beginFill(3289649, 0.85);
            graphics.drawRect(0, 0, _loc_2.textfield.textWidth + 10, height + 8);
            return;
        }// end function

    }
}
