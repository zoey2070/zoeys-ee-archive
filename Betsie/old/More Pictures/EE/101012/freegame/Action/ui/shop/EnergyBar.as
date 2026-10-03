package ui.shop
{

    public class EnergyBar extends assets_energybar
    {
        private var amount:Number = 0;
        private var max:Number = 1000;

        public function EnergyBar(param1:Number)
        {
            this.max = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            tf_energy.width = param1;
            border.width = param1;
            glow.width = param1 - 1;
            color_bg.width = param1 - 2;
            bg.width = param1;
            this.setEnergy(this.amount);
            return;
        }// end function

        public function setEnergy(param1:Number) : void
        {
            this.amount = param1;
            tf_energy.text = param1 + "/" + this.max;
            progress_mask.width = (width - 2) * Math.min(param1 / this.max, 1);
            return;
        }// end function

        public function getEnergy() : Number
        {
            return this.amount;
        }// end function

    }
}
