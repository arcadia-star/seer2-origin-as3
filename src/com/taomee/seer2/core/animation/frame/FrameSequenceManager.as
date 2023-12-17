package com.taomee.seer2.core.animation.frame
{
   import com.taomee.seer2.core.cache.CacheManager;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.utils.ByteArray;
   import org.taomee.ds.HashMap;
   
   public class FrameSequenceManager
   {
      
      private static var _frameSequenceMap:HashMap = new HashMap();
       
      
      public function FrameSequenceManager()
      {
         super();
      }
      
      public static function getFrameSequence(param1:String, param2:String = null, param3:Boolean = false) : FrameSequence
      {
         var _loc4_:FrameSequence = null;
         var _loc5_:ByteArray = null;
         if(_frameSequenceMap.containsKey(param1))
         {
            _loc4_ = _frameSequenceMap.getValue(param1) as FrameSequence;
            _loc4_.referredCount += 1;
         }
         else if(param3 == true)
         {
            _loc4_ = new FrameSequence();
            _loc4_.referredCount += 1;
            _loc5_ = UIManager.getByteArray(param1);
            _loc4_.setData(_loc5_);
            _frameSequenceMap.add(param1,_loc4_);
         }
         else
         {
            _loc4_ = new FrameSequence();
            _loc4_.referredCount += 1;
            _frameSequenceMap.add(param1,_loc4_);
            loadSequenceResource(param1,param2);
         }
         return _loc4_;
      }
      
      public static function recyleFrameSequence(param1:FrameSequence) : void
      {
         var _loc2_:String = null;
         --param1.referredCount;
         if(param1.referredCount == 0)
         {
            _loc2_ = String(_frameSequenceMap.getKey(param1));
            param1.dispose();
            QueueLoader.cancel(_loc2_,onResourLoaded);
            _frameSequenceMap.remove(_loc2_);
         }
      }
      
      private static function loadSequenceResource(param1:String, param2:String) : void
      {
         if(param2 == null)
         {
            QueueLoader.load(param1,LoadType.BINARY,onResourLoaded);
         }
         else
         {
            CacheManager.getContent(param1,param2,onResourLoaded);
         }
      }
      
      private static function onResourLoaded(param1:ContentInfo) : void
      {
         var _loc2_:FrameSequence = _frameSequenceMap.getValue(param1.url) as FrameSequence;
         if(_loc2_)
         {
            _loc2_.setData(param1.content);
         }
      }
   }
}
