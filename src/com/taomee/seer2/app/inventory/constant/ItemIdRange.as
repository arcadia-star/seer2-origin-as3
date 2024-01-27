package com.taomee.seer2.app.inventory.constant {
public class ItemIdRange {

    public static const BASIC:Vector.<int> = Vector.<int>([1, 100000]);

    public static const EQUIP:Vector.<int> = Vector.<int>([100001, 199999]);

    public static const PET_RELATE:Vector.<int> = Vector.<int>([200001, 299999]);

    public static const EMBLEM:Vector.<int> = Vector.<int>([300001, 399999]);

    public static const COLLECTION:Vector.<int> = Vector.<int>([400001, 499999]);

    public static const MEDAL:Vector.<int> = Vector.<int>([500001, 500500]);

    public static const SPECIAL_ITEM:Vector.<int> = Vector.<int>([500501, 610000]);

    public static const PET_SPIRT_TRAIN:Vector.<int> = Vector.<int>([800001, 805999]);


    public function ItemIdRange() {
        super();
    }
}
}
