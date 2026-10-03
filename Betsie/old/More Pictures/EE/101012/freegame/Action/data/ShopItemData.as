package data
{
    import flash.display.*;

    public class ShopItemData extends Object
    {
        public var id:String;
        public var priceEnergy:int;
        public var priceEnergyClick:int;
        public var priceGems:int;
        public var energyUsed:int = 0;
        public var owned_count:int;
        public var isPlayerWorldOnly:Boolean;
        public var isOnSale:Boolean;
        public var isNew:Boolean;
        public var isFeatured:Boolean;
        public var isGridFeatured:Boolean;
        public var isClassic:Boolean;
        public var isDevOnly:Boolean;
        public var span:int = 1;
        public var text_header:String = "";
        public var text_body:String = "";
        public var glow_color:int = 7769269;
        public var bitmapsheet_id:String;
        public var bitmapsheet_offset:int;
        public var type:String;
        public var image_bitmap:BitmapData;
        public var isDollars:Boolean = false;
        public var owned:Boolean;
        public var grid_x:int;
        public var grid_y:int;
        public static const TYPE_SMILEY:String = "smiley";
        public static const TYPE_BRICK:String = "brick";
        public static const TYPE_WORLD:String = "world";
        public static const TYPE_POTION:String = "potion";
        public static const TYPE_OTHER:String = "other";

        public function ShopItemData(param1:String, param2:String, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:String, param10:String, param11:String, param12:int, param13:Boolean, param14:Boolean, param15:Boolean, param16:Boolean, param17:Boolean, param18:Boolean, param19:Boolean)
        {
            this.id = param1;
            this.type = param2;
            this.priceEnergy = param3;
            this.priceEnergyClick = param4;
            this.energyUsed = param5;
            this.priceGems = param6;
            this.owned_count = param7;
            this.span = param8;
            this.text_header = param9;
            this.text_body = param10;
            this.bitmapsheet_id = param11.length > 0 ? (param11) : (null);
            this.bitmapsheet_offset = param12;
            this.isOnSale = param13;
            this.isFeatured = param14;
            this.isClassic = param15;
            this.isPlayerWorldOnly = param16;
            this.isNew = param17;
            this.isDevOnly = param18;
            this.isGridFeatured = param19;
            return;
        }// end function

        public function get label() : String
        {
            return this.isOnSale ? ("sale") : (this.isNew ? ("new") : (null));
        }// end function

        public function get max_count() : int
        {
            return this.type == TYPE_POTION ? (Config.shop_potion_max) : (0);
        }// end function

    }
}
