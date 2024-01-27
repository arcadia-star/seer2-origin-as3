package com.taomee.seer2.app.inventory.utils {
import com.taomee.seer2.app.inventory.constant.ItemCategory;
import com.taomee.seer2.app.inventory.constant.ItemIdRange;

public class ItemCategoryUtil {


    public function ItemCategoryUtil() {
        super();
    }

    public static function findItemCategoryByReferenceId(param1:uint):int {
        if (checkInRange(param1, ItemIdRange.BASIC)) {
            return ItemCategory.BASIC;
        }
        if (checkInRange(param1, ItemIdRange.EQUIP)) {
            return ItemCategory.EQUIP;
        }
        if (checkInRange(param1, ItemIdRange.PET_RELATE)) {
            return ItemCategory.PET_RELATE;
        }
        if (checkInRange(param1, ItemIdRange.EMBLEM)) {
            return ItemCategory.EMBLEM;
        }
        if (checkInRange(param1, ItemIdRange.COLLECTION)) {
            return ItemCategory.COLLECTION;
        }
        if (checkInRange(param1, ItemIdRange.MEDAL)) {
            return ItemCategory.MEDAL;
        }
        if (checkInRange(param1, ItemIdRange.SPECIAL_ITEM)) {
            return ItemCategory.SPECIAL_ITEM;
        }
        if (checkInRange(param1, ItemIdRange.PET_SPIRT_TRAIN)) {
            return ItemCategory.PET_SPIRT_TRAIN;
        }
        return ItemCategory.COLLECTION;
    }

    private static function checkInRange(param1:int, param2:Vector.<int>):Boolean {
        if (param1 >= param2[0] && param1 <= param2[1]) {
            return true;
        }
        return false;
    }

    public static function isMedal(param1:int):Boolean {
        return ItemCategoryUtil.findItemCategoryByReferenceId(param1) == ItemCategory.MEDAL;
    }

    public static function isEmblem(param1:int):Boolean {
        return ItemCategoryUtil.findItemCategoryByReferenceId(param1) == ItemCategory.EMBLEM;
    }
}
}
