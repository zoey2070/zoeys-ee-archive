package ui.shop
{
    import flash.text.*;

    public class ShopItemTitle extends assets_itemtitle
    {

        public function ShopItemTitle(param1:String)
        {
            title.defaultTextFormat = new TextFormat(null, null, null, true);
            title.text = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            title.width = param1;
            return;
        }// end function

    }
}
