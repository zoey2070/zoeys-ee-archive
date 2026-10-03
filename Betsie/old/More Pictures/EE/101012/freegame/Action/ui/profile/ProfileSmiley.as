package ui.profile
{
    import flash.display.*;
    import items.*;
    import sample.ui.components.*;

    public class ProfileSmiley extends Box
    {
        private var bm:Bitmap;

        public function ProfileSmiley(param1:ItemSmiley)
        {
            var _loc_2:Label = null;
            border(1, 3355443, 1);
            fill(1118481, 1, 5);
            margin(NaN, NaN, 0);
            this.bm = new Bitmap(param1.bmd);
            addChild(this.bm);
            _loc_2 = new Label(param1.name, 12, "center", 16777215, false, "visitor");
            _loc_2.y = 21;
            addChild(_loc_2);
            this.bm.x = (_loc_2.width - this.bm.width - 2) / 2 >> 0;
            this.width = width;
            this.height = 34;
            this.bm.y = 2;
            return;
        }// end function

    }
}
