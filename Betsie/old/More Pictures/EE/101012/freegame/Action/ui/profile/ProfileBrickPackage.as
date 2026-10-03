package ui.profile
{
    import __AS3__.vec.*;
    import flash.display.*;
    import flash.geom.*;
    import items.*;
    import sample.ui.components.*;

    public class ProfileBrickPackage extends Box
    {
        private var bm:Bitmap;

        public function ProfileBrickPackage(param1:ItemBrickPackage, param2:Vector.<ItemBrick>)
        {
            var _loc_3:Label = null;
            border(1, 3355443, 1);
            fill(1118481, 1, 5);
            margin(NaN, NaN, 0);
            _loc_3 = new Label(param1.name, 12, "left", 16777215, false, "visitor");
            addChild(_loc_3);
            var _loc_4:* = new BitmapData(param2.length * 17 + 1, 18, false, 0);
            this.bm = new Bitmap(_loc_4);
            addChild(this.bm);
            var _loc_5:int = 0;
            while (_loc_5 < param2.length)
            {
                
                _loc_4.copyPixels(ItemManager.getBrickById(0).bmd, ItemManager.getBrickById(0).bmd.rect, new Point(_loc_5 * 17 + 1, 1));
                _loc_4.copyPixels(param2[_loc_5].bmd, param2[_loc_5].bmd.rect, new Point(_loc_5 * 17 + 1, 1));
                _loc_5++;
            }
            this.width = width + 2;
            this.height = 31;
            _loc_3.x = 1;
            _loc_3.y = 1;
            this.bm.y = 12;
            return;
        }// end function

    }
}
