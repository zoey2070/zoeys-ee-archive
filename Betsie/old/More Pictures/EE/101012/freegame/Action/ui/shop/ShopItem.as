package ui.shop
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import data.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ShopItem extends assets_shopitem
    {
        private var base_width:Number;
        private var base_height:Number;
        private var base_width_over:Number;
        private var base_height_over:Number;
        private var base_down_margin_over:Number;
        protected var is_mouse_over:Boolean = false;
        private var bg:ShopItemBg;
        private var btn_energy:ButtonEnergy;
        private var btn_buy:ButtonBuy;
        private var itemtext:ShopItemText;
        private var itemtitle:ShopItemTitle;
        private var imageloader:Loader;
        private var image:Sprite;
        private var imagemask:Sprite;
        private var mainmask:Sprite;
        public var itemdata:ShopItemData;
        private var label:ShopItemLabel;
        private var count:ShopItemCount;
        private var energy:ShopItemEnergy;
        private var item_playerworld:ShopItemPlayerWorld;
        private var imagebitmap:Sprite;
        private var owned:ShopItemOwned;
        private var maxed:ShopItemMax;

        public function ShopItem(param1:ShopItemData, param2:Number, param3:Number)
        {
            this.itemdata = param1;
            addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage, false, 0, true);
            mouseEnabled = false;
            mouseChildren = true;
            this.base_width = param2;
            this.base_height = param3;
            this.base_width_over = this.base_width + 50;
            this.base_height_over = this.base_height + 70;
            this.base_down_margin_over = 55;
            this.bg = new ShopItemBg(this.base_width, this.base_height);
            addChild(this.bg);
            this.image = new Sprite();
            addChild(this.image);
            this.imagemask = new Sprite();
            this.imagemask.graphics.beginFill(0);
            this.imagemask.graphics.drawRect(0, 0, this.base_width, this.base_height);
            addChild(this.imagemask);
            this.image.mask = this.imagemask;
            this.itemtitle = new ShopItemTitle(param1.text_header);
            this.itemtitle.width = this.base_width_over;
            if (param1.span == 1)
            {
                addChild(this.itemtitle);
            }
            this.energy = new ShopItemEnergy(param1.energyUsed, param1.priceEnergy);
            this.energy.alpha = 0;
            addChild(this.energy);
            if (param1.priceEnergy < 0)
            {
                this.energy.visible = false;
            }
            this.btn_buy = new ButtonBuy(param1.priceGems);
            this.btn_buy.addEventListener(MouseEvent.MOUSE_DOWN, this.handleButtonClick, false, 0, true);
            if (param1.isDollars)
            {
                this.btn_buy.showAsDollars();
            }
            addChild(this.btn_buy);
            if (param1.priceGems < 0)
            {
                this.btn_buy.visible = false;
            }
            this.btn_energy = new ButtonEnergy(param1.priceEnergyClick, param1.energyUsed, param1.priceEnergy);
            this.btn_energy.addEventListener(MouseEvent.MOUSE_DOWN, this.handleButtonClick, false, 0, true);
            addChild(this.btn_energy);
            if (param1.priceEnergy < 0)
            {
                this.btn_energy.visible = false;
            }
            if (param1.priceEnergy < 0 && param1.priceGems < 0)
            {
                this.base_down_margin_over = 0;
                buttonMode = true;
                mouseEnabled = true;
                mouseChildren = false;
                addEventListener(MouseEvent.MOUSE_DOWN, this.handleButtonClick, false, 0, true);
            }
            this.itemtext = new ShopItemText(param1.text_header, param1.text_body);
            this.itemtext.width = this.base_width_over - this.btn_buy.width - this.btn_energy.width - 15;
            if (param1.span > 1)
            {
                addChild(this.itemtext);
            }
            if (param1.label)
            {
                this.label = new ShopItemLabel(param1.label);
                addChild(this.label);
            }
            if (param1.owned_count)
            {
                this.count = new ShopItemCount(param1.owned_count, param1.max_count);
                this.count.alpha = 0;
                addChild(this.count);
            }
            if (param1.isPlayerWorldOnly)
            {
                this.item_playerworld = new ShopItemPlayerWorld();
                this.item_playerworld.alpha = 0;
                addChild(this.item_playerworld);
            }
            TweenMax.allTo([this.btn_buy, this.btn_energy, this.itemtext, this.itemtitle], 0, {autoAlpha:0});
            var _loc_4:* = new Bitmap(param1.image_bitmap);
            this.imagebitmap = new Sprite();
            this.imagebitmap.addChild(_loc_4);
            this.image.addChild(this.imagebitmap);
            this.image.alpha = 0;
            this.setItemdata(param1);
            if (this.is_mouse_over)
            {
                this.handleMouseOver();
            }
            else
            {
                this.handleMouseOut(true);
            }
            return;
        }// end function

        public function setItemdata(param1:ShopItemData) : void
        {
            this.itemdata = param1;
            if (this.count != null)
            {
                this.count.setCount(this.itemdata.owned_count, this.itemdata.max_count);
            }
            this.btn_energy.setEnergy(this.itemdata.energyUsed);
            this.energy.energybar.setEnergy(this.itemdata.energyUsed);
            this.btn_energy.buttonMode = true;
            this.btn_energy.mouseEnabled = true;
            this.btn_buy.buttonMode = true;
            this.btn_buy.mouseEnabled = true;
            if (param1.owned && this.owned == null)
            {
                this.btn_buy.alpha = 0.2;
                this.btn_buy.buttonMode = false;
                this.btn_buy.mouseEnabled = false;
                this.btn_energy.alpha = this.itemdata.priceEnergy > 0 ? (0.2) : (0);
                this.btn_energy.buttonMode = false;
                this.btn_energy.mouseEnabled = false;
                this.owned = new ShopItemOwned();
                this.owned.alpha = 0;
                addChild(this.owned);
                if (this.is_mouse_over)
                {
                    this.handleMouseOver();
                }
                else
                {
                    this.handleMouseOut(true);
                }
            }
            if (this.itemdata.max_count > 0 && this.itemdata.owned_count >= this.itemdata.max_count && this.maxed == null)
            {
                this.btn_buy.alpha = 0.2;
                this.btn_buy.buttonMode = false;
                this.btn_buy.mouseEnabled = false;
                this.btn_energy.alpha = this.itemdata.priceEnergy > 0 ? (0.2) : (0);
                this.btn_energy.buttonMode = false;
                this.btn_energy.mouseEnabled = false;
                this.maxed = new ShopItemMax();
                this.maxed.alpha = 0;
                addChild(this.maxed);
                if (this.is_mouse_over)
                {
                    this.handleMouseOver();
                }
                else
                {
                    this.handleMouseOut(true);
                }
            }
            return;
        }// end function

        protected function handleButtonClick(event:Event) : void
        {
            if (event.target == this.btn_energy)
            {
                this.btn_energy.buttonMode = false;
                this.btn_energy.mouseEnabled = false;
                dispatchEvent(new ShopItemEvent(ShopItemEvent.USE_ENERGY, true));
            }
            else if (event.target == this.btn_buy)
            {
                this.btn_buy.buttonMode = false;
                this.btn_buy.mouseEnabled = false;
                dispatchEvent(new ShopItemEvent(ShopItemEvent.BUY_ITEM, true));
            }
            else
            {
                dispatchEvent(new ShopItemEvent(ShopItemEvent.CLICK_ITEM, true));
            }
            return;
        }// end function

        protected function handleAddedToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
            addEventListener(MouseEvent.MOUSE_OVER, this.handleMouse, false, 0, true);
            addEventListener(MouseEvent.MOUSE_OUT, this.handleMouse, false, 0, true);
            return;
        }// end function

        protected function handleRemovedFromStage(event:Event) : void
        {
            removeEventListener(Event.REMOVED_FROM_STAGE, this.handleRemovedFromStage);
            removeEventListener(MouseEvent.MOUSE_OVER, this.handleMouse);
            removeEventListener(MouseEvent.MOUSE_OUT, this.handleMouse);
            addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage, false, 0, true);
            return;
        }// end function

        protected function handleMouse(event:MouseEvent) : void
        {
            var _loc_2:* = this.bg.getBounds(this);
            if (event.type == MouseEvent.MOUSE_OVER)
            {
                _loc_2.inflate(1, 1);
            }
            else
            {
                _loc_2.inflate(-1, -1);
            }
            if (!_loc_2.contains(mouseX, mouseY) && this.is_mouse_over)
            {
                this.handleMouseOut();
                dispatchEvent(new ShopItemEvent(ShopItemEvent.MOUSE_OUT, true, false));
            }
            else if (_loc_2.contains(mouseX, mouseY) && !this.is_mouse_over)
            {
                this.handleMouseOver();
                dispatchEvent(new ShopItemEvent(ShopItemEvent.MOUSE_OVER, true, false));
            }
            return;
        }// end function

        protected function handleMouseOver() : void
        {
            this.is_mouse_over = true;
            this.bg.setSize(this.base_width_over, this.base_height_over);
            this.bg.dropshadow = true;
            this.scaleLabel(1);
            this.showCount(true);
            this.showEnergyBar(false);
            this.showButtons(true, 0.2, 0.2);
            this.showPlayerWorldOnly(true, 0.2, 0.2);
            if (this.itemdata.type == ShopItemData.TYPE_SMILEY || this.itemdata.type == ShopItemData.TYPE_POTION)
            {
                this.scaleImage(5, -3);
                this.glowImage(50, 3);
                this.scaleImageMask(this.base_width_over, this.base_height_over, 0.4);
            }
            else
            {
                this.scaleImage(1, -35, 0.2);
                this.glowImage(10, 1);
                this.scaleImageMask(this.base_width_over, this.base_height_over - this.base_down_margin_over, 0.4);
            }
            return;
        }// end function

        protected function handleMouseOut(param1:Boolean = false) : void
        {
            this.is_mouse_over = false;
            this.bg.setSize(this.base_width, this.base_height);
            this.bg.dropshadow = false;
            this.scaleLabel(1);
            this.showCount(false);
            this.showEnergyBar(true);
            this.showButtons(false, 0, 0);
            this.btn_energy.setGlow(0);
            this.showPlayerWorldOnly(false, 0, 0);
            if (this.itemdata.type == ShopItemData.TYPE_SMILEY || this.itemdata.type == ShopItemData.TYPE_POTION)
            {
                this.scaleImage(3, 0, param1 ? (0) : (0.2));
                this.glowImage(20, 1.5);
                this.scaleImageMask(this.base_width, this.base_height, param1 ? (0) : (0.4));
            }
            else
            {
                this.scaleImage(1, -15, param1 ? (0) : (0.2));
                this.glowImage(2, 1);
                this.scaleImageMask(this.base_width, this.base_height, param1 ? (0) : (0.4));
            }
            return;
        }// end function

        public function forceMouseOut() : void
        {
            if (this.is_mouse_over)
            {
                this.handleMouseOut();
                dispatchEvent(new ShopItemEvent(ShopItemEvent.MOUSE_OUT, true, false));
            }
            return;
        }// end function

        protected function scaleLabel(param1:Number = 1) : void
        {
            var scale:* = param1;
            if (this.label)
            {
                TweenMax.to(this.label, 0.4, {scaleX:scale, scaleY:scale, onUpdate:function () : void
            {
                label.x = bg.x - 1;
                label.y = bg.y - 1;
                return;
            }// end function
            , ease:Linear.easeNone});
            }
            return;
        }// end function

        private function showPlayerWorldOnly(param1:Boolean, param2:Number = 0.5, param3:Number = 0) : void
        {
            var value:* = param1;
            var time:* = param2;
            var delay:* = param3;
            if (this.item_playerworld)
            {
                TweenMax.to(this.item_playerworld, time, {delay:delay, autoAlpha:value ? (1) : (0), onUpdate:function () : void
            {
                if (itemdata.span > 1)
                {
                    item_playerworld.x = bg.x + bg.width - item_playerworld.width - 7 >> 0;
                    item_playerworld.y = itemtext.y >> 0;
                }
                else
                {
                    item_playerworld.x = bg.x + (bg.width - item_playerworld.width) / 2 - 4 >> 0;
                    item_playerworld.y = btn_energy.y - item_playerworld.height >> 0;
                }
                return;
            }// end function
            , ease:Back.easeOut, overwrite:OverwriteManager.ALL_IMMEDIATE});
            }
            return;
        }// end function

        protected function showCount(param1:Boolean) : void
        {
            var value:* = param1;
            if (this.count)
            {
                TweenMax.to(this.count, 0.4, {autoAlpha:value ? (1) : (0), onUpdate:function () : void
            {
                count.x = bg.x + bg.width - count.width;
                count.y = 1 + bg.y;
                return;
            }// end function
            , ease:Back.easeOut});
            }
            return;
        }// end function

        protected function glowImage(param1:Number, param2:Number) : void
        {
            TweenMax.to(this.image, 0.2, {glowFilter:{color:this.itemdata.glow_color, alpha:1, blurX:param1, blurY:param1, strength:param2}, ease:Linear.easeNone});
            return;
        }// end function

        protected function scaleImage(param1:Number, param2:Number = 0, param3:Number = 0.2) : void
        {
            var scale:* = param1;
            var offset_y:* = param2;
            var time:* = param3;
            if (this.imagebitmap != null)
            {
                TweenMax.to(this.imagebitmap, time, {y:offset_y});
            }
            TweenMax.to(this.image, time, {alpha:1, scaleX:scale, scaleY:scale, ease:Back.easeOut, onUpdate:function () : void
            {
                image.x = base_width / 2 - image.width / 2;
                image.y = base_height / 2 - image.height / 2;
                return;
            }// end function
            });
            return;
        }// end function

        protected function scaleImageMask(param1:Number, param2:Number, param3:Number) : void
        {
            var w:* = param1;
            var h:* = param2;
            var time:* = param3;
            TweenMax.to(this.imagemask, time, {width:w - 10, height:h - 10, ease:Back.easeOut, onUpdate:function () : void
            {
                imagemask.x = bg.x + 5;
                imagemask.y = bg.y + 5;
                return;
            }// end function
            });
            return;
        }// end function

        protected function showEnergyBar(param1:Boolean, param2:Number = 0.5, param3:Number = 0) : void
        {
            var value:* = param1;
            var time:* = param2;
            var delay:* = param3;
            TweenMax.to(this.energy, time, {autoAlpha:value && this.itemdata.energyUsed && !this.itemdata.owned && this.itemdata.priceEnergy > 0 ? (1) : (0), delay:delay, onUpdate:function () : void
            {
                energy.x = bg.x + bg.width - energy.width;
                energy.y = bg.y + bg.height - energy.height;
                return;
            }// end function
            , overwrite:OverwriteManager.ALL_IMMEDIATE});
            return;
        }// end function

        protected function showButtons(param1:Boolean, param2:Number = 0.5, param3:Number = 0) : void
        {
            var value:* = param1;
            var time:* = param2;
            var delay:* = param3;
            var btns:Array;
            if (this.itemdata.priceEnergy > 0)
            {
                btns.push(this.btn_energy);
            }
            if (this.itemdata.priceGems > 0)
            {
                btns.push(this.btn_buy);
            }
            if (this.owned)
            {
                btns.push(this.owned);
            }
            if (this.maxed)
            {
                btns.push(this.maxed);
            }
            TweenMax.allTo(btns, time, {autoAlpha:value ? (1) : (0), delay:delay, onUpdate:function () : void
            {
                btn_buy.y = bg.y + bg.height - btn_buy.height - 5;
                btn_buy.x = bg.x + bg.width - btn_buy.width - 1;
                if (itemdata.span > 1)
                {
                    btn_energy.y = bg.y + bg.height - btn_energy.height - 5;
                    btn_energy.x = btn_buy.x - btn_energy.width - 5;
                    itemtext.y = bg.y + bg.height - itemtext.height - 5 >> 0;
                    itemtext.x = bg.x + 5 >> 0;
                    itemtitle.visible = false;
                }
                else
                {
                    btn_energy.y = bg.y + bg.height - btn_energy.height - 5;
                    btn_energy.x = bg.x + 6;
                    itemtitle.x = bg.x >> 0;
                    itemtitle.y = bg.y + bg.height - btn_energy.height - itemtitle.height - 13 >> 0;
                    itemtitle.width = bg.width;
                }
                if (owned != null)
                {
                    owned.x = bg.x + bg.width - owned.width - 20;
                    owned.y = bg.y + bg.height - owned.height - 10;
                    btn_buy.alpha = 0.2;
                    btn_energy.alpha = itemdata.priceEnergy > 0 ? (0.2) : (0);
                }
                if (maxed != null)
                {
                    maxed.x = bg.x + bg.width - maxed.width - 20;
                    maxed.y = bg.y + bg.height - maxed.height - 10;
                    btn_buy.alpha = 0.2;
                    btn_energy.alpha = itemdata.priceEnergy > 0 ? (0.2) : (0);
                }
                return;
            }// end function
            , overwrite:OverwriteManager.ALL_IMMEDIATE});
            return;
        }// end function

        public function get span() : int
        {
            return this.itemdata.span;
        }// end function

        override public function get height() : Number
        {
            return this.bg.height;
        }// end function

        override public function get width() : Number
        {
            return this.bg.width;
        }// end function

    }
}
