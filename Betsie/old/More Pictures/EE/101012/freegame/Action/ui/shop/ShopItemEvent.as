package ui.shop
{
    import flash.events.*;

    public class ShopItemEvent extends Event
    {
        public static const MOUSE_OVER:String = "shopitem_mouseover";
        public static const MOUSE_OUT:String = "shopitem_mouseout";
        public static const CLICK_ITEM:String = "click_item";
        public static const USE_ENERGY:String = "use_energy";
        public static const BUY_ITEM:String = "buy_item";

        public function ShopItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            super(param1, param2, param3);
            return;
        }// end function

    }
}
