package items
{
    import flash.display.*;

    public class ItemSmiley extends Object
    {
        public var id:int;
        public var name:String;
        public var payvaultid:String = null;
        public var description:String;
        public var bmd:BitmapData;
        public var minimapcolor:uint;

        public function ItemSmiley(param1:int, param2:String, param3:String, param4:BitmapData, param5:String, param6:uint)
        {
            this.id = param1;
            this.name = param2;
            this.description = param3;
            this.bmd = param4;
            this.payvaultid = param5;
            this.minimapcolor = param6;
            return;
        }// end function

    }
}
