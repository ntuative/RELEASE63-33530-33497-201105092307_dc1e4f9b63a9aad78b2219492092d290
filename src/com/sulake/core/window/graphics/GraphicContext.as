package com.sulake.core.window.graphics
{
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.display.MorphShape;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class GraphicContext extends Sprite implements IGraphicContext
   {
      
      public static const GC_TYPE_UNKNOWN:uint = 0;
      
      public static const GC_TYPE_BITMAP:uint = 1;
      
      public static const GC_TYPE_TEXTFIELD:uint = 2;
      
      public static const GC_TYPE_CONTAINER:uint = 4;
      
      public static const GC_TYPE_SHAPE:uint = 8;
      
      public static const GC_TYPE_MORPH_SHAPE:uint = 16;
      
      public static const const_2143:uint = 64;
      
      public static const const_2080:uint = 128;
      
      public static const GC_TYPE_DESKTOP:uint = 256;
      
      protected static var var_573:uint = 0;
      
      protected static var var_336:uint = 0;
       
      
      protected var var_214:DisplayObjectContainer;
      
      protected var var_2131:Boolean;
      
      protected var var_862:Boolean;
      
      protected var _disposed:Boolean = false;
      
      protected var var_11:Rectangle;
      
      protected var var_193:Shape;
      
      public function GraphicContext(param1:String, param2:uint, param3:Rectangle)
      {
         var _loc4_:* = null;
         super();
         ++var_573;
         if(param3 == null)
         {
            param3 = new Rectangle(0,0,0,0);
         }
         this.name = param1;
         this.mouseEnabled = false;
         this.doubleClickEnabled = false;
         this.x = param3.x;
         this.y = param3.y;
         this.var_11 = param3.clone();
         this.var_2131 = true;
         this.var_862 = false;
         switch(param2)
         {
            case GraphicContext.GC_TYPE_BITMAP:
               this.var_862 = true;
               this.setDisplayObject(new Bitmap());
               this.allocateDrawBuffer(param3.width,param3.height);
               break;
            case GraphicContext.GC_TYPE_TEXTFIELD:
               _loc4_ = new TextField();
               _loc4_.width = param3.width;
               _loc4_.height = param3.height;
               _loc4_.type = TextFieldType.INPUT;
               this.setDisplayObject(_loc4_);
               break;
            case GraphicContext.GC_TYPE_SHAPE:
               this.setDisplayObject(new Shape());
               break;
            case GraphicContext.GC_TYPE_MORPH_SHAPE:
               this.setDisplayObject(new MorphShape());
               break;
            case GraphicContext.GC_TYPE_CONTAINER:
               this.setDisplayObject(new Sprite());
               break;
            case GraphicContext.GC_TYPE_DESKTOP:
               break;
            case GraphicContext.GC_TYPE_UNKNOWN:
               break;
            default:
               throw new Error("Unsupported graphic context type: " + param2 + "!");
         }
      }
      
      public static function get numGraphicContexts() : uint
      {
         return var_573;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_336;
      }
      
      public function set parent(param1:DisplayObjectContainer) : void
      {
         if(parent != null)
         {
            parent.removeChild(this);
         }
         if(param1 != null)
         {
            param1.addChild(this);
         }
      }
      
      override public function get filters() : Array
      {
         return this.getDisplayObject().filters;
      }
      
      override public function set filters(param1:Array) : void
      {
         this.getDisplayObject().filters = param1;
      }
      
      public function get blend() : Number
      {
         return this.alpha;
      }
      
      public function set blend(param1:Number) : void
      {
         this.alpha = param1;
      }
      
      public function get mouse() : Boolean
      {
         return super.mouseEnabled;
      }
      
      public function set mouse(param1:Boolean) : void
      {
         super.mouseEnabled = param1;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function dispose() : void
      {
         if(!this._disposed)
         {
            if(parent != null)
            {
               parent.removeChild(this);
               this.parent = null;
            }
            while(this.numChildContexts > 0)
            {
               this.removeChildContextAt(0);
            }
            if(this.var_862)
            {
               this.releaseDrawBuffer();
            }
            if(this.var_214 != null)
            {
               while(this.var_214.numChildren > 0)
               {
                  this.var_214.removeChildAt(0);
               }
            }
            this.var_214 = null;
            while(numChildren > 0)
            {
               removeChildAt(0);
            }
            this.var_193 = null;
            this._disposed = true;
            --var_573;
         }
      }
      
      override public function toString() : String
      {
         return "[object GraphicContext name=\"" + name + "\"]";
      }
      
      public function getDrawRegion() : Rectangle
      {
         return this.var_11.clone();
      }
      
      public function setDrawRegion(param1:Rectangle, param2:Boolean, param3:Rectangle) : void
      {
         if(this.var_862 && param2)
         {
            this.allocateDrawBuffer(param1.width,param1.height);
         }
         x = param1.x;
         y = param1.y;
         this.var_11.x = param1.x;
         this.var_11.y = param1.y;
         this.var_11.width = param1.width;
         this.var_11.height = param1.height;
         if(param3)
         {
            if(!this.var_193)
            {
               this.var_193 = new Shape();
               this.var_193.visible = false;
               this.var_193.cacheAsBitmap = true;
               super.addChild(this.var_193);
            }
            this.var_193.graphics.clear();
            this.var_193.graphics.beginFill(255);
            this.var_193.graphics.drawRect(param3.x,param3.y,param3.width,param3.height);
            this.var_193.graphics.endFill();
            this.getDisplayObject().mask = this.var_193;
         }
         else if(this.var_193)
         {
            super.removeChild(this.var_193);
            this.var_193.graphics.clear();
            this.var_193 = null;
            this.getDisplayObject().mask = null;
         }
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getChildAt(0);
      }
      
      public function setDisplayObject(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:* = null;
         if(numChildren > 0)
         {
            _loc2_ = removeChildAt(0);
         }
         addChildAt(param1,0);
         param1.cacheAsBitmap = true;
         param1.mask = this.var_193;
         return _loc2_;
      }
      
      public function getAbsoluteMousePosition(param1:Point) : void
      {
         param1.x = stage.mouseX;
         param1.y = stage.mouseY;
      }
      
      public function getRelativeMousePosition(param1:Point) : void
      {
         var _loc2_:DisplayObject = this.getDisplayObject();
         param1.x = _loc2_.mouseX;
         param1.y = _loc2_.mouseY;
      }
      
      public function fetchDrawBuffer() : IBitmapDrawable
      {
         var _loc1_:* = null;
         if(this.var_862)
         {
            _loc1_ = this.getDisplayObject();
            if(_loc1_ != null)
            {
               return Bitmap(_loc1_).bitmapData;
            }
         }
         return null;
      }
      
      protected function allocateDrawBuffer(param1:int, param2:int) : BitmapData
      {
         var displayObject:DisplayObject = null;
         var bitmap:BitmapData = null;
         var width:int = param1;
         var height:int = param2;
         if(this.var_862)
         {
            displayObject = this.getDisplayObject();
            if(displayObject is Bitmap)
            {
               bitmap = Bitmap(displayObject).bitmapData;
               if(bitmap != null)
               {
                  if(bitmap.width != width || bitmap.height != height)
                  {
                     var_336 -= bitmap.width * bitmap.height * 4;
                     bitmap.dispose();
                     bitmap = null;
                  }
               }
               if(bitmap == null && width > 0 && height > 0)
               {
                  try
                  {
                     bitmap = new TrackedBitmapData(this,width,height,this.var_2131,16777215);
                  }
                  catch(e:Error)
                  {
                     bitmap = new TrackedBitmapData(this,1,1,var_2131,16777215);
                  }
                  var_336 += bitmap.width * bitmap.height * 4;
               }
               Bitmap(displayObject).bitmapData = bitmap;
               return bitmap;
            }
         }
         return null;
      }
      
      protected function releaseDrawBuffer() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.var_862)
         {
            _loc1_ = this.getDisplayObject();
            if(_loc1_ is Bitmap)
            {
               _loc2_ = Bitmap(_loc1_).bitmapData;
               if(_loc2_ != null)
               {
                  var_336 -= _loc2_.width * _loc2_.height * 4;
                  _loc2_.dispose();
               }
            }
         }
      }
      
      public function showRedrawRegion(param1:Rectangle) : void
      {
         graphics.clear();
         graphics.lineStyle(1,4278255360);
         graphics.drawRect(0,0,width,height);
         if(param1 != null)
         {
            graphics.lineStyle(1,4278190335);
            graphics.drawRect(param1.x,param1.y,param1.width,param1.height);
         }
      }
      
      protected function setupChildContainer() : DisplayObjectContainer
      {
         if(this.var_214 == null)
         {
            this.var_214 = new Sprite();
            this.var_214.name = this.name + " - Child Container";
            this.var_214.mouseEnabled = false;
            addChild(this.var_214);
         }
         return this.var_214;
      }
      
      protected function removeChildContainer() : void
      {
         if(this.var_214 != null)
         {
            removeChild(this.var_214);
            this.var_214 = null;
         }
      }
      
      public function get numChildContexts() : int
      {
         return this.var_214 != null ? int(this.var_214.numChildren) : 0;
      }
      
      public function addChildContext(param1:IGraphicContext) : IGraphicContext
      {
         return this.setupChildContainer().addChild(param1 as DisplayObject) as IGraphicContext;
      }
      
      public function addChildContextAt(param1:IGraphicContext, param2:int) : IGraphicContext
      {
         return this.setupChildContainer().addChildAt(param1 as DisplayObject,param2) as IGraphicContext;
      }
      
      public function getChildContextAt(param1:int) : IGraphicContext
      {
         return this.setupChildContainer().getChildAt(param1) as IGraphicContext;
      }
      
      public function getChildContextByName(param1:String) : IGraphicContext
      {
         return this.setupChildContainer().getChildByName(param1) as IGraphicContext;
      }
      
      public function getChildContextIndex(param1:IGraphicContext) : int
      {
         return this.setupChildContainer().getChildIndex(DisplayObject(param1));
      }
      
      public function removeChildContext(param1:IGraphicContext) : IGraphicContext
      {
         return this.setupChildContainer().removeChild(DisplayObject(param1)) as IGraphicContext;
      }
      
      public function removeChildContextAt(param1:int) : IGraphicContext
      {
         var _loc2_:IGraphicContext = this.setupChildContainer().getChildAt(param1) as IGraphicContext;
         return _loc2_ == null ? null : this.removeChildContext(_loc2_);
      }
      
      public function setChildContextIndex(param1:IGraphicContext, param2:int) : void
      {
         var current:int = 0;
         var temp:Array = null;
         var i:uint = 0;
         var child:IGraphicContext = param1;
         var index:int = param2;
         var dispObj:DisplayObject = child as DisplayObject;
         if(dispObj != null)
         {
            try
            {
               current = this.setupChildContainer().getChildIndex(dispObj);
            }
            catch(error:ArgumentError)
            {
               temp = new Array();
               i = 0;
               while(i < numChildContexts)
               {
                  temp.push(getChildContextAt(i));
                  i++;
               }
               throw new Error("Provided display object is not a child of this!");
            }
            if(index != current)
            {
               this.setupChildContainer().setChildIndex(dispObj,index);
            }
            return;
         }
         throw new Error("Provided child must implement IGraphicContext!");
      }
      
      public function swapChildContexts(param1:IGraphicContext, param2:IGraphicContext) : void
      {
         this.setupChildContainer().swapChildren(param1 as DisplayObject,param2 as DisplayObject);
      }
      
      public function swapChildContextsAt(param1:int, param2:int) : void
      {
         this.setupChildContainer().swapChildrenAt(param1,param2);
      }
   }
}
