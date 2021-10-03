package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.IDisposable;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import flash.display.BitmapData;
   
   public class DrawBufferAllocator implements IDisposable
   {
       
      
      private var _disposed:Boolean;
      
      private var var_647:Array;
      
      public function DrawBufferAllocator()
      {
         super();
         this._disposed = false;
         this.var_647 = new Array();
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get allocatedByteCount() : uint
      {
         var bitmap:BitmapData = null;
         var bytes:uint = 0;
         var index:uint = this.var_647.length;
         try
         {
            while(index > 0)
            {
               index--;
               bitmap = BitmapData(this.var_647[index]);
               bytes += bitmap.width * bitmap.height * 4;
            }
         }
         catch(e:Error)
         {
            Logger.log("Disposed bitmap in DrawBufferAllocator!");
         }
         return bytes;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = 0;
         if(!this._disposed)
         {
            this._disposed = true;
            _loc1_ = uint(this.var_647.length);
            while(_loc1_ > 0)
            {
               BitmapData(this.var_647.pop()).dispose();
               _loc1_--;
            }
         }
      }
      
      public function allocate(param1:int, param2:int, param3:Boolean = true, param4:uint = 4.294967295E9) : BitmapData
      {
         var bitmap:BitmapData = null;
         var width:int = param1;
         var height:int = param2;
         var transparent:Boolean = param3;
         var fillColor:uint = param4;
         try
         {
            bitmap = new TrackedBitmapData(this,width,height,transparent,fillColor);
         }
         catch(error:ArgumentError)
         {
            Logger.log("Failed to allocate draw buffer of size " + width + "x" + height + "!");
            bitmap = new TrackedBitmapData(this,1,1,transparent,fillColor);
         }
         this.var_647.push(bitmap);
         return bitmap;
      }
      
      public function free(param1:BitmapData) : void
      {
         var _loc2_:uint = this.var_647.indexOf(param1);
         if(_loc2_ < 0)
         {
            throw new ArgumentError("Provided bitmap data is not managed by this instance!");
         }
         this.var_647.splice(_loc2_,1);
         param1.dispose();
      }
   }
}
