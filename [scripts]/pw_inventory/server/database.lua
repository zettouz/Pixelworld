function checkItemCount(type, id, item, count, cb)
	MySQL.Async.fetchScalar('SELECT SUM(count) FROM `stored_items` WHERE `inventoryType` = @type AND `identifier` = @id AND item = @item', { ['item'] = item, ['type'] = type, ['id'] = id }, function(has)
		if has ~= nil then
			cb(has >= count)
		else
			cb(false)
		end
	end)
end

function checkItemCountRt(type, id, item, count)
	local processed = false
	local currentCount = 0
	MySQL.Async.fetchScalar('SELECT SUM(count) FROM `stored_items` WHERE `inventoryType` = @type AND `identifier` = @id AND item = @item', { ['item'] = item, ['type'] = type, ['id'] = id }, function(has)
		if has ~= nil then
			if(has >= count)then
				currentCount = has
			end
		end
		processed = true
	end)
	repeat Wait(0) until processed == true
	return currentCount
end

function removeItemFromInventory(type, id, item, count)
	local done = false
	local total = count
	local toDelete = ""
	MySQL.Async.fetchScalar('SELECT SUM(count) FROM `stored_items` WHERE `inventoryType` = @type AND `identifier` = @id AND item = @item', { ['item'] = item, ['type'] = type, ['id'] = id }, function(has)
		if has ~= nil then
			if(has >= count)then
				MySQL.Async.fetchAll('SELECT * FROM `stored_items` WHERE `inventoryType` = @type AND `identifier` = @id AND item = @item', { ['item'] = item, ['type'] = type, ['id'] = id }, function(itemSlots)
					for k,v in pairs(itemSlots) do
						local processed = false
						if total <= 0 then
							done = true
							processed = true
						elseif v.count <= total then
							MySQL.Async.execute("DELETE FROM `stored_items` WHERE `record_id` = @rec", {['@rec'] = v.record_id}, function()
								total = total - v.count
								processed = true
							end)
						elseif v.count > total then
							local remaining = v.count - total
							MySQL.Async.execute("UPDATE `stored_items` SET `count` = @remain WHERE `record_id` = @rec", { ['@remain'] = remaining, ['@rec'] = v.record_id }, function()
								total = 0
								processed = true
							end)							
						end
						repeat Wait(0) until processed == true
						if done then break; end
					end
				end)
			end
		end
	end)
		
	return done
end

exports('checkItemCount', function(type, id, item, count)
	return checkItemCountRt(type, id, item, count)
end)

exports('removeItemFromInventory', function(type, id, item, count)
	return removeItemFromInventory(type, id, item, count)
end)