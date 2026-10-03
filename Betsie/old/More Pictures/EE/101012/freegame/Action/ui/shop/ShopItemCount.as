package ui.shop
{
    import flash.text.*;

    public class ShopItemCount extends assets_itemcount
    {

        public function ShopItemCount(param1:int, param2:int)
        {
            count.autoSize = TextFieldAutoSize.LEFT;
            this.setCount(param1, param2);
            return;
        }// end function

        public function setCount(param1:int, param2:int) : void
        {
            count.text = "You have: " + param1 + (param2 > 0 ? (" / " + param2) : (""));
            bg.width = count.width + 10;
            return;
        }// end function

    }
}
