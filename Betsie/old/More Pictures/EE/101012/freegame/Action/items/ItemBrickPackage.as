package items
{
    import __AS3__.vec.*;

    public class ItemBrickPackage extends Object
    {
        public var name:String;
        public var description:String;
        public var bricks:Vector.<ItemBrick>;

        public function ItemBrickPackage(param1:String, param2:String)
        {
            this.bricks = new Vector.<ItemBrick>;
            this.name = param1;
            this.description = param2;
            return;
        }// end function

        public function addBrick(param1:ItemBrick) : void
        {
            this.bricks.push(param1);
            return;
        }// end function

    }
}
