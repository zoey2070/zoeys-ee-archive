package sample.ui.components
{
    import flash.text.*;

    public class Label extends TextField
    {

        public function Label(param1:String, param2:Number = 12, param3:String = "left", param4:Number = 0, param5:Boolean = false, param6:String = null)
        {
            var _loc_7:* = new TextFormat();
            new TextFormat().font = param6 || "Arial";
            if (param6)
            {
                embedFonts = true;
                antiAliasType = AntiAliasType.ADVANCED;
            }
            _loc_7.align = param3;
            _loc_7.size = param2;
            _loc_7.color = param4;
            this.defaultTextFormat = _loc_7;
            this.sharpness = 400;
            super.text = param1;
            this.selectable = false;
            this.mouseEnabled = false;
            if (param5)
            {
                this.multiline = true;
                this.wordWrap = true;
            }
            this.resize();
            return;
        }// end function

        override public function set text(param1:String) : void
        {
            super.text = param1;
            this.resize();
            return;
        }// end function

        override public function set htmlText(param1:String) : void
        {
            super.htmlText = param1;
            this.mouseEnabled = true;
            this.resize();
            return;
        }// end function

        public function clear() : void
        {
            super.text = "";
            return;
        }// end function

        private function resize() : void
        {
            this.width = this.textWidth + 10;
            this.height = this.textHeight + (this.defaultTextFormat.size as Number) / 2;
            return;
        }// end function

        override public function get height() : Number
        {
            return this.textHeight + 3;
        }// end function

        public function Clone() : Label
        {
            return new Label(this.text, this.defaultTextFormat.size as Number, this.defaultTextFormat.align);
        }// end function

    }
}
