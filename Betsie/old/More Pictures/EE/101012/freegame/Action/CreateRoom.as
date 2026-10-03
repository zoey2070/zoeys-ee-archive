package 
{
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CreateRoom extends MovieClip
    {
        public var start:SimpleButton;
        public var closebtn:SimpleButton;
        public var editkey:TextField;
        public var roomname:TextField;

        public function CreateRoom(param1:Function)
        {
            var self:CreateRoom;
            var callback:* = param1;
            this.roomname.embedFonts = true;
            this.roomname.defaultTextFormat = new TextFormat(new system().fontName, 14);
            this.roomname.restrict = "0-9 A-Za-z";
            this.roomname.maxChars = 25;
            this.roomname.text = ["The", "My", "Our"][Math.random() * 3 >> 0] + [" Awesome", " Cool", " Spectacular", " Pretty", " Wild", " Great", " Fun", ""][Math.random() * 8 >> 0] + [" World", " Creation", " Room", " Area"][Math.random() * 4 >> 0];
            this.editkey.embedFonts = true;
            this.editkey.defaultTextFormat = new TextFormat(new system().fontName, 14);
            this.editkey.restrict = "0-9 A-Za-z";
            this.editkey.maxChars = 25;
            self;
            this.start.addEventListener(MouseEvent.CLICK, function () : void
            {
                if (roomname.text.replace(/ "" /gi, "") != "")
                {
                    self.parent.removeChild(self);
                    callback(roomname.text, editkey.text, true);
                }
                return;
            }// end function
            );
            this.closebtn.addEventListener(MouseEvent.CLICK, function () : void
            {
                self.parent.removeChild(self);
                return;
            }// end function
            );
            return;
        }// end function

    }
}
