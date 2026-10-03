package ui.brickoverlays
{
    import ui2.*;

    public class PropertiesBackground extends ui2properties
    {

        public function PropertiesBackground()
        {
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            bg.width = param1;
            bg.height = param2 - 10;
            bg.x = (-param1) / 2;
            bg.y = -param2;
            arrow.x = (-arrow.width) / 2;
            arrow.y = -10;
            return;
        }// end function

        public function setOffsetX(param1:Number) : void
        {
            var _loc_2:int = 0;
            while (_loc_2 < numChildren)
            {
                
                getChildAt(_loc_2).x = getChildAt(_loc_2).x + param1;
                _loc_2++;
            }
            arrow.x = (-arrow.width) / 2;
            return;
        }// end function

    }
}
