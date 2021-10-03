package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.IWindowContainer;
   import com.sulake.core.window.components.IBitmapWrapperWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.IAvatarImage;
   import com.sulake.habbo.avatar.animation.IAnimationLayerData;
   import com.sulake.habbo.avatar.animation.IAvatarDataContainer;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.enum.AvatarAction;
   import com.sulake.habbo.avatar.enum.AvatarScaleType;
   import com.sulake.habbo.avatar.enum.AvatarSetType;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.enum.ProductTypeEnum;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.ProductImageConfiguration;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.WidgetEvent;
   import com.sulake.habbo.room.IGetImageListener;
   import com.sulake.habbo.room.ImageResult;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.habbo.window.IHabboWindowManager;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class ProductViewCatalogWidget extends CatalogWidget implements ICatalogWidget, IGetImageListener
   {
       
      
      private var var_2033:BitmapData;
      
      private var var_1048:ITextWindow;
      
      private var var_1277:ITextWindow;
      
      private var var_87:IBitmapWrapperWindow;
      
      private var var_2032:Point;
      
      private var var_561:IItemGridWindow;
      
      private var var_1578:IScrollbarWindow;
      
      protected var var_1920:XML;
      
      private var var_2808:Array;
      
      public function ProductViewCatalogWidget(param1:IWindowContainer)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.var_2033 = null;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         this.var_1048 = _window.findChildByName("ctlg_product_name") as ITextWindow;
         this.var_1277 = _window.findChildByName("ctlg_description") as ITextWindow;
         this.var_87 = _window.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow;
         this.var_2032 = new Point(this.var_87.x,this.var_87.y);
         this.var_561 = _window.findChildByName("bundleGrid") as IItemGridWindow;
         this.var_1578 = _window.findChildByName("bundleGridScrollbar") as IScrollbarWindow;
         if(this.var_561 == null)
         {
            Logger.log("[ProductViewCatalogWidget] Bundle Grid not initialized!");
         }
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         this.var_1920 = _loc1_.content as XML;
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset;
         this.var_2033 = _loc2_.content as BitmapData;
         events.addEventListener(WidgetEvent.CWE_SELECT_PRODUCT,this.onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc12_:* = null;
         var _loc13_:* = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = null;
         var _loc18_:* = null;
         var _loc19_:* = null;
         var _loc20_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         if(param1 == null)
         {
            return;
         }
         this.removeEffectSprites();
         _loc2_ = param1.offer;
         if(this.var_561 != null)
         {
            this.var_561.visible = false;
            this.var_561.destroyGridItems();
         }
         if(this.var_1578 != null)
         {
            this.var_1578.visible = false;
         }
         var _loc3_:IProductData = page.viewer.catalog.getProductData(_loc2_.localizationId);
         if(_loc3_ != null)
         {
            _loc4_ = "${" + _loc3_.name + "}";
            _loc5_ = "${" + _loc3_.description + "}";
         }
         else
         {
            _loc4_ = "${" + _loc2_.localizationId + "}";
            _loc5_ = "${" + _loc2_.localizationId + "}";
         }
         this.var_1048.text = _loc4_;
         this.var_1277.text = _loc5_;
         this.var_1048.height = this.var_1048.textHeight + 5;
         this.var_1277.y = this.var_1048.y + this.var_1048.height;
         this.var_1277.height = Math.max(130,this.var_1277.textHeight + 5);
         if(ProductImageConfiguration.hasProductImage(_loc2_.localizationId))
         {
            this.setPreviewFromAsset(ProductImageConfiguration.const_32[_loc2_.localizationId]);
         }
         else
         {
            _loc7_ = new Point(0,0);
            switch(_loc2_.pricingModel)
            {
               case Offer.const_561:
                  _loc6_ = this.var_2033.clone();
                  if(this.var_561 != null)
                  {
                     this.var_561.visible = true;
                     _loc10_ = _loc2_.productContainer as BundleProductContainer;
                     _loc10_.populateItemGrid(this.var_561,this.var_1578,this.var_1920);
                     this.var_561.scrollV = 0;
                  }
                  break;
               case Offer.const_444:
               case Offer.const_406:
                  _loc8_ = _loc2_.productContainer.firstProduct;
                  switch(_loc8_.productType)
                  {
                     case ProductTypeEnum.const_78:
                        _loc9_ = page.viewer.roomEngine.getFurnitureImage(_loc8_.productClassId,new Vector3d(90,0,0),64,this,0,_loc8_.extraParam);
                        _loc2_.previewCallbackId = _loc9_.id;
                        break;
                     case ProductTypeEnum.const_66:
                        _loc9_ = page.viewer.roomEngine.getWallItemImage(_loc8_.productClassId,new Vector3d(90,0,0),64,this,0,_loc8_.extraParam);
                        _loc2_.previewCallbackId = _loc9_.id;
                        break;
                     case ProductTypeEnum.const_205:
                        _loc11_ = page.viewer.catalog.windowManager;
                        _loc12_ = _window.findChildByName("pixelsBackground") as IWindowContainer;
                        _loc13_ = 4291611852;
                        if(_loc12_ != null)
                        {
                           _loc12_.visible = true;
                           _loc13_ = uint(_loc12_.color);
                        }
                        _loc6_ = new BitmapData(this.var_87.width,this.var_87.height,false,_loc13_);
                        _loc14_ = null;
                        _loc15_ = page.viewer.catalog as HabboCatalog;
                        if(_loc15_.avatarRenderManager != null)
                        {
                           _loc17_ = _loc15_.sessionDataManager.figure;
                           _loc16_ = _loc15_.avatarRenderManager.createAvatarImage(_loc17_,AvatarScaleType.const_56);
                           if(_loc16_ != null)
                           {
                              _loc16_.setDirection(AvatarSetType.const_51,3);
                              _loc16_.initActionAppends();
                              _loc16_.appendAction(AvatarAction.const_301,AvatarAction.const_532);
                              _loc16_.appendAction(AvatarAction.const_365,_loc8_.productClassId);
                              _loc16_.endActionAppends();
                              _loc16_.updateAnimationByFrames(1);
                              _loc16_.updateAnimationByFrames(1);
                              _loc14_ = _loc16_.getImage(AvatarSetType.const_35,true);
                              _loc18_ = new Point(0,0);
                              if(_loc14_ != null)
                              {
                                 _loc20_ = _loc16_.avatarSpriteData;
                                 if(_loc20_ != null)
                                 {
                                 }
                                 _loc18_.x = (_loc6_.width - _loc14_.width) / 2;
                                 _loc18_.y = (_loc6_.height - _loc14_.height) / 2;
                                 for each(_loc21_ in _loc16_.getSprites())
                                 {
                                    if(_loc21_.id == "avatar")
                                    {
                                       _loc22_ = _loc16_.getLayerData(_loc21_);
                                       _loc7_.x = _loc22_.dx;
                                       _loc7_.y = _loc22_.dy;
                                    }
                                 }
                              }
                              _loc19_ = new Point(0,_loc14_.height - 16);
                              this.addEffectSprites(_loc6_,_loc16_,_loc7_,_loc18_.add(_loc19_),false);
                              _loc6_.copyPixels(_loc14_,_loc14_.rect,_loc18_,null,null,true);
                              this.addEffectSprites(_loc6_,_loc16_,_loc7_,_loc18_.add(_loc19_));
                           }
                        }
                        if(_loc16_)
                        {
                           _loc16_.dispose();
                        }
                        break;
                     case ProductTypeEnum.const_355:
                        break;
                     default:
                        Logger.log("[ProductViewCatalogWidget] Unknown Product Type: " + _loc8_.productType);
                  }
                  if(_loc9_ != null)
                  {
                     _loc6_ = _loc9_.data;
                  }
                  break;
               default:
                  Logger.log("[ProductViewCatalogWidget] Unknown pricing model" + _loc2_.pricingModel);
            }
            this.setPreviewImage(_loc6_,true,_loc7_);
         }
         _window.invalidate();
      }
      
      private function addEffectSprites(param1:BitmapData, param2:IAvatarImage, param3:Point, param4:Point, param5:Boolean = true) : void
      {
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc16_:* = null;
         var _loc17_:* = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:* = null;
         for each(_loc6_ in param2.getSprites())
         {
            _loc7_ = _window.getChildIndex(this.var_87);
            _loc8_ = param2.getLayerData(_loc6_);
            _loc9_ = 0;
            _loc10_ = _loc6_.getDirectionOffsetX(param2.getDirection());
            _loc11_ = _loc6_.getDirectionOffsetY(param2.getDirection());
            _loc12_ = _loc6_.getDirectionOffsetZ(param2.getDirection());
            _loc13_ = 0;
            if(!param5)
            {
               if(_loc12_ >= 0)
               {
                  continue;
               }
            }
            else if(_loc12_ < 0)
            {
               continue;
            }
            if(_loc6_.hasDirections)
            {
               _loc13_ = param2.getDirection();
            }
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.animationFrame;
               _loc10_ += _loc8_.dx;
               _loc11_ += _loc8_.dy;
               _loc13_ += _loc8_.directionOffset;
            }
            if(_loc13_ < 0)
            {
               _loc13_ += 8;
            }
            if(_loc13_ > 7)
            {
               _loc13_ -= 8;
            }
            _loc14_ = param2.getScale() + "_" + _loc6_.member + "_" + _loc13_ + "_" + _loc9_;
            _loc15_ = param2.getAsset(_loc14_);
            if(_loc15_ != null)
            {
               _loc16_ = (_loc15_.content as BitmapData).clone();
               _loc17_ = 1;
               _loc18_ = param4.x - 1 * _loc15_.offset.x + _loc10_;
               _loc19_ = param4.y - 1 * _loc15_.offset.y + _loc11_;
               if(_loc6_.ink == 33)
               {
                  _loc20_ = new Matrix(1,0,0,1,_loc18_ - param3.x,_loc19_ - param3.y);
                  param1.draw(_loc16_,_loc20_,null,BlendMode.ADD,null,false);
               }
               else
               {
                  param1.copyPixels(_loc16_,_loc16_.rect,new Point(_loc18_ - param3.x,_loc19_ - param3.y));
               }
            }
         }
      }
      
      private function removeEffectSprites() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in this.var_2808)
         {
            _window.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.var_2808 = new Array();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:* = null;
         if(disposed || page == null || true)
         {
            return;
         }
         for each(_loc3_ in page.offers)
         {
            if(_loc3_.previewCallbackId == param1)
            {
               this.setPreviewImage(param2,true);
               _loc3_.previewCallbackId = 0;
               break;
            }
         }
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean, param3:Point = null) : void
      {
         var _loc4_:* = null;
         if(this.var_87 != null && true)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            if(this.var_87.bitmap == null)
            {
               this.var_87.bitmap = new BitmapData(this.var_87.width,this.var_87.height,true,16777215);
            }
            this.var_87.bitmap.fillRect(this.var_87.bitmap.rect,16777215);
            _loc4_ = new Point((this.var_87.width - param1.width) / 2,(this.var_87.height - param1.height) / 2);
            this.var_87.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
            this.var_87.invalidate();
            this.var_87.x = this.var_2032.x;
            this.var_87.y = this.var_2032.y;
            if(param3 != null)
            {
               this.var_87.x += param3.x;
               this.var_87.y += param3.y;
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         if(!param1 || !page || true || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return;
         }
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            this.retrievePreviewAsset(param1);
            return;
         }
         this.setPreviewImage(_loc2_.content as BitmapData,false);
      }
      
      private function retrievePreviewAsset(param1:String) : void
      {
         if(!param1 || !page || true || !page.viewer.catalog || !page.viewer.catalog.configuration)
         {
            return;
         }
         var _loc2_:String = page.viewer.catalog.configuration.getKey("image.library.catalogue.url");
         var _loc3_:* = _loc2_ + param1 + ".gif";
         Logger.log("[ProductViewCatalogWidget] Retrieve Product Preview Asset: " + _loc3_);
         var _loc4_:URLRequest = new URLRequest(_loc3_);
         if(!page.viewer.catalog.assets)
         {
            return;
         }
         var _loc5_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc4_,"image/gif");
         if(!_loc5_)
         {
            return;
         }
         _loc5_.addEventListener(AssetLoaderEvent.const_29,this.onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            this.setPreviewFromAsset(_loc2_.assetName);
         }
      }
   }
}
