package com.taomee.seer2.app.seriesActivity.xieesiling
{
   import com.taomee.seer2.app.seriesActivity.SeriesActivityController;
   
   public class XieesilingController extends SeriesActivityController
   {
       
      
      private const _configObjs:Array = [{
         "panelPrefix":"TianShiLingZun",
         "petId":2550,
         "wenZhangBuyId":203556,
         "zhiZunBuyId":606910,
         "addFengyinFightNumBuyId":606916,
         "addFightNumBuyId":606911,
         "fightIds":[1782,1783,1784,1785,1786],
         "fengyinFightNumId":1905,
         "fightNumId":1906,
         "fightFlagId":1907,
         "fightDamageId":1908,
         "swapId":4524,
         "xingzuanFengyinByStartId":606912,
         "petFlag":206339
      },{
         "panelPrefix":"XieNianMoZun",
         "petId":2551,
         "wenZhangBuyId":203557,
         "zhiZunBuyId":606917,
         "addFengyinFightNumBuyId":606923,
         "addFightNumBuyId":606918,
         "fightIds":[1787,1788,1789,1790,1791],
         "fengyinFightNumId":1902,
         "fightNumId":1903,
         "fightFlagId":1904,
         "fightDamageId":1908,
         "swapId":4526,
         "xingzuanFengyinByStartId":606919,
         "petFlag":206339
      },{
         "panelPrefix":"AnYiMoSheng",
         "petId":2552,
         "wenZhangBuyId":203558,
         "zhiZunBuyId":606924,
         "addFengyinFightNumBuyId":606930,
         "addFightNumBuyId":606925,
         "fightIds":[1793,1794,1795,1796,1797],
         "fengyinFightNumId":1908,
         "fightNumId":1909,
         "fightFlagId":1910,
         "fightDamageId":1908,
         "swapId":4528,
         "xingzuanFengyinByStartId":606926,
         "petFlag":206339
      },{
         "panelPrefix":"AnYouMiQian",
         "petId":2555,
         "wenZhangBuyId":203564,
         "zhiZunBuyId":606973,
         "addFengyinFightNumBuyId":606979,
         "addFightNumBuyId":606974,
         "fightIds":[1828,1829,1830,1831,1832],
         "fengyinFightNumId":1947,
         "fightNumId":1948,
         "fightFlagId":1949,
         "fightDamageId":1908,
         "swapId":4574,
         "xingzuanFengyinByStartId":606975,
         "petFlag":206339
      }];
      
      public function XieesilingController()
      {
         super();
         _configClass = XieesilingConfig;
         _configs = this._configObjs;
         initConfigs();
      }
   }
}
