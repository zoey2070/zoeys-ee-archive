package ui.shop
{
    import flash.text.*;

    public class ShopItemText extends assets_itemtext
    {

        public function ShopItemText(param1:String, param2:String)
        {
            body.autoSize = TextFieldAutoSize.NONE;
            header.defaultTextFormat = new TextFormat(null, null, null, true);
            header.htmlText = param1;
            body.htmlText = param2;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            body.width = param1;
            return;
        }// end function

        override public function get height() : Number
        {
            return body.y + body.height;
        }// end function

    }
}
