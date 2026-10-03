package ui.shop
{
    import flash.text.*;

    public class ShopItemPlayerWorld extends assets_itemplayerworld
    {

        public function ShopItemPlayerWorld()
        {
            text.autoSize = TextFieldAutoSize.LEFT;
            text.defaultTextFormat = new TextFormat(null, null, null, true);
            text.text = "(Only for your worlds)";
            return;
        }// end function

        override public function get width() : Number
        {
            return text.textWidth;
        }// end function

    }
}
