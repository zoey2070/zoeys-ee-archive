package ui.shop
{

    public class ShopItemEnergy extends assets_itemenergy
    {
        public var energybar:EnergyBar;

        public function ShopItemEnergy(param1:Number, param2:Number)
        {
            this.energybar = new EnergyBar(param2);
            this.energybar.width = width - 6;
            this.energybar.x = 3;
            this.energybar.y = height - this.energybar.height;
            this.energybar.setEnergy(param1);
            addChild(this.energybar);
            return;
        }// end function

    }
}
