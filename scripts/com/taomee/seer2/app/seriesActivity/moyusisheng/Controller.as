package com.taomee.seer2.app.seriesActivity.moyusisheng
{
   import com.taomee.seer2.app.seriesActivity.SeriesActivityController;
   
   public class Controller extends SeriesActivityController
   {
       
      
      private const _configObjs:Array = [{
         "fightNums":1995,
         "fightId":1867,
         "boxStartId":206415,
         "currentBoxIndex":206420,
         "boxStartTime":206421,
         "itemNumId":206419,
         "startSwapId":4630,
         "openBoxSwapId":4631,
         "getPetSwapId":4633,
         "fightNumById":607087,
         "jiasuBuyId":607088,
         "petBuyId":607086,
         "itemBuyId":607089,
         "moduleName":"XieEMoShenPanel",
         "petId":2579,
         "wenzhangBuyId":203622,
         "boxName":"邪恶魔晶",
         "itemName":"邪魔之力"
      },{
         "fightNums":2000,
         "fightId":1881,
         "boxStartId":206440,
         "currentBoxIndex":206445,
         "boxStartTime":206446,
         "itemNumId":206444,
         "startSwapId":4645,
         "openBoxSwapId":4646,
         "getPetSwapId":4647,
         "fightNumById":607097,
         "jiasuBuyId":607098,
         "petBuyId":607096,
         "itemBuyId":607099,
         "moduleName":"LianyuMoShenPanel",
         "petId":2580,
         "wenzhangBuyId":203626,
         "boxName":"魔魂之器",
         "itemName":"炼魔之魂"
      },{
         "fightNums":2010,
         "fightId":1889,
         "boxStartId":206453,
         "currentBoxIndex":206458,
         "boxStartTime":206459,
         "itemNumId":206457,
         "startSwapId":4666,
         "openBoxSwapId":4667,
         "getPetSwapId":4668,
         "fightNumById":607115,
         "jiasuBuyId":607113,
         "petBuyId":607112,
         "itemBuyId":607114,
         "moduleName":"DestoryMoShenPanel",
         "petId":2581,
         "wenzhangBuyId":203629,
         "boxName":"崩坏魔盒",
         "itemName":"破灭精元"
      }];
      
      public function Controller()
      {
         super();
         _configClass = Config;
         _configs = this._configObjs;
         initConfigs();
      }
   }
}
