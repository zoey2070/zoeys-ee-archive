package ui.shop
{
    import sample.ui.components.scroll.*;

    public class GridScrollContaioner extends ScrollContainer
    {
        private var currentgrid:ShopGrid;

        public function GridScrollContaioner()
        {
            return;
        }// end function

        override public function get height() : Number
        {
            var _loc_1:Number = 0;
            var _loc_2:int = 0;
            while (_loc_2 < numChildren)
            {
                
                _loc_1 = Math.max(_loc_1, getChildAt(_loc_2).y + getChildAt(_loc_2).height);
                _loc_2++;
            }
            return _loc_1;
        }// end function

    }
}
