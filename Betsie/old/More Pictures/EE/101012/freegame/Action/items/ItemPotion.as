package items
{
    import flash.display.*;

    public class ItemPotion extends Object
    {
        public var id:int;
        public var name:String;
        public var payvaultid:String = null;
        public var description:String;
        public var bmd:BitmapData;

        public function ItemPotion(param1:int, param2:String, param3:String, param4:BitmapData, param5:String)
        {
            this.id = param1;
            this.name = param2;
            this.description = param3;
            this.bmd = param4;
            this.payvaultid = param5;
            return;
        }// end function

    }
}
