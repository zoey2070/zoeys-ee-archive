package sample.ui.components.scroll
{
    import flash.display.*;

    public class ScrollContainer extends Sprite
    {
        protected var componentWidth:Number = 0;

        public function ScrollContainer()
        {
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            var _loc_2:int = 0;
            var _loc_3:DisplayObject = null;
            mouseEnabled = true;
            if (this.componentWidth != param1)
            {
                _loc_2 = 0;
                while (_loc_2 < numChildren)
                {
                    
                    _loc_3 = getChildAt(_loc_2);
                    _loc_3.width = param1 - 1;
                    _loc_2++;
                }
                this.componentWidth = param1;
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            return;
        }// end function

    }
}
