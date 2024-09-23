-- Population

use first_task;

-- Drop all database tables data

SET FOREIGN_KEY_CHECKS = 0;  -- Deshabilitar la comprobación de claves foráneas

TRUNCATE TABLE Players;
TRUNCATE TABLE Virtual_Items;
TRUNCATE TABLE Achievements;
TRUNCATE TABLE Financial_Transactions;
TRUNCATE TABLE Achiev_Player;
TRUNCATE TABLE Support_And_Customer_Service;

SET FOREIGN_KEY_CHECKS = 1;  -- Volver a habilitar la comprobación de claves foráneas


-- Insertar 10 registros en la tabla Players
INSERT INTO Players (ID_Player, Name, Email, Password, Registration_Date)
VALUES 
(1, 'John Doe', 'john.doe@example.com', 'hashedpassword123', '2023-09-15 12:30:00'),
(2, 'Jane Smith', 'jane.smith@example.com', 'hashedpassword456', '2023-08-20 15:45:00'),
(3, 'Alex Brown', 'alex.brown@example.com', 'hashedpassword789', '2023-09-22 09:10:00'),
(4, 'Chris White', 'chris.white@example.com', 'hashedpassword101', '2023-07-19 10:30:00'),
(5, 'Sara Green', 'sara.green@example.com', 'hashedpassword202', '2023-06-18 11:20:00'),
(6, 'Mike Black', 'mike.black@example.com', 'hashedpassword303', '2023-05-21 08:50:00'),
(7, 'Nina Blue', 'nina.blue@example.com', 'hashedpassword404', '2023-04-25 09:30:00'),
(8, 'Lara Yellow', 'lara.yellow@example.com', 'hashedpassword505', '2023-03-30 12:40:00'),
(9, 'Tom Gray', 'tom.gray@example.com', 'hashedpassword606', '2023-02-17 16:10:00'),
(10, 'Emma Pink', 'emma.pink@example.com', 'hashedpassword707', '2023-01-10 17:50:00');


-- Insertar 10 registros en la tabla Virtual Items
INSERT INTO Virtual_Items (ID_Item, ID_Player, Item_Name, Description, Price, Category)
VALUES 
(1, 1, 'Sword of Destiny', 'A powerful sword with magical properties.', 99.99, 'Weapon'),
(2, 2, 'Dragon Shield', 'A shield made from dragon scales.', 150.50, 'Armor'),
(3, 3, 'Healing Potion', 'Restores 50% of health instantly.', 5.99, 'Consumable'),
(4, 4, 'Magic Staff', 'A staff that amplifies magical abilities.', 120.00, 'Weapon'),
(5, 5, 'Invisibility Cloak', 'Grants temporary invisibility.', 200.75, 'Accessory'),
(6, 6, 'Phoenix Feather', 'Revives the player once upon death.', 300.00, 'Rare Item'),
(7, 7, 'Warrior Helmet', 'Protects against physical damage.', 75.49, 'Armor'),
(8, 8, 'Teleportation Stone', 'Allows fast travel between locations.', 50.00, 'Consumable'),
(9, 9, 'Golden Bow', 'A bow with enhanced accuracy and range.', 110.99, 'Weapon'),
(10, 10, 'Mana Potion', 'Restores 75% of mana.', 15.49, 'Consumable');


-- Insertar 10 registros en la tabla Achievements
INSERT INTO Achievements (ID_Achievement, Achievement_Name, Description, Rewards, Difficulty_Level)
VALUES 
(1, 'First Blood', 'Complete your first mission', '500 XP, 100 Gold', 1),
(2, 'Dragon Slayer', 'Defeat the Dragon Boss', '1500 XP, 300 Gold', 5),
(3, 'Treasure Hunter', 'Find the hidden treasure', '1000 XP, 200 Gold', 3),
(4, 'Speed Runner', 'Complete a mission in under 5 minutes', '200 XP, 50 Gold', 2),
(5, 'Sharpshooter', 'Achieve 100 headshots', '700 XP, 150 Gold', 4),
(6, 'Master Strategist', 'Win 10 games without losing a unit', '1200 XP, 250 Gold', 5),
(7, 'Collector', 'Gather all rare items in the game', '900 XP, 180 Gold', 3),
(8, 'Explorer', 'Visit all regions in the game', '600 XP, 120 Gold', 2),
(9, 'Unstoppable', 'Win 20 consecutive matches', '1400 XP, 280 Gold', 4),
(10, 'Survivor', 'Survive for 10 hours in a survival mode', '1600 XP, 300 Gold', 5);


-- Insertar 10 registros en la tabla Financial Transactions
INSERT INTO Financial_Transactions (ID_Transaction, ID_Player, Transaction_Type, Date_Time, Amount, Currency, Payment_Method, Transaction_Status)
VALUES 
(1, 1, 'Purchase', '2023-09-16 10:00:00', 99.99, 'USD', 'Credit Card', 'Completed'),
(2, 2, 'Deposit', '2023-09-18 14:30:00', 150.50, 'USD', 'PayPal', 'Pending'),
(3, 3, 'Purchase', '2023-09-22 11:45:00', 5.99, 'USD', 'Debit Card', 'Completed'),
(4, 4, 'Purchase', '2023-09-25 14:15:00', 120.00, 'USD', 'Credit Card', 'Completed'),
(5, 5, 'Purchase', '2023-09-26 09:30:00', 200.75, 'USD', 'Debit Card', 'Completed'),
(6, 6, 'Purchase', '2023-09-27 13:50:00', 300.00, 'USD', 'Credit Card', 'Completed'),
(7, 7, 'Deposit', '2023-09-28 16:20:00', 75.49, 'USD', 'PayPal', 'Completed'),
(8, 8, 'Purchase', '2023-09-29 08:00:00', 50.00, 'USD', 'Debit Card', 'Completed'),
(9, 9, 'Purchase', '2023-09-30 17:00:00', 110.99, 'USD', 'Credit Card', 'Pending'),
(10, 10, 'Deposit', '2023-10-01 10:00:00', 15.49, 'USD', 'Credit Card', 'Completed');


-- Insertar 10 registros en la tabla Achiev_Player
INSERT INTO Achiev_Player (ID_Achievement, ID_Player, Date)
VALUES 
(1, 1, '2023-09-16 11:00:00'),
(2, 2, '2023-09-18 15:00:00'),
(3, 3, '2023-09-22 12:00:00'),
(4, 4, '2023-09-25 14:45:00'),
(5, 5, '2023-09-26 10:15:00'),
(6, 6, '2023-09-27 14:00:00'),
(7, 7, '2023-09-28 17:30:00'),
(8, 8, '2023-09-29 08:30:00'),
(9, 9, '2023-09-30 18:15:00'),
(10, 10, '2023-10-01 10:30:00');


-- Insertar 10 registros en la tabla Support and Customer Service
INSERT INTO Support_And_Customer_Service (ID_Ticket, ID_Player, Creation_Date, Problem_Category, Problem_Description, Priority, Ticket_Status, Support_Agent_ID, Last_Updated_Date)
VALUES 
(1, 1, '2023-09-17 08:30:00', 'Technical Issue', 'Cannot log into my account', 'High', 'Open', 101, '2023-09-17 09:00:00'),
(2, 2, '2023-09-18 10:45:00', 'Payment Issue', 'Transaction not showing up', 'Medium', 'In Progress', 102, '2023-09-18 11:00:00'),
(3, 3, '2023-09-19 13:20:00', 'Gameplay Bug', 'Item disappeared from inventory', 'Low', 'Closed', 103, '2023-09-20 14:00:00'),
(4, 4, '2023-09-20 09:15:00', 'Account Issue', 'Email not being recognized', 'High', 'Open', 104, '2023-09-21 11:00:00'),
(5, 5, '2023-09-21 14:40:00', 'Gameplay Bug', 'Cannot enter dungeon level', 'Medium', 'Open', 105, '2023-09-21 15:00:00'),
(6, 6, '2023-09-22 10:50:00', 'Technical Issue', 'Game keeps crashing', 'High', 'In Progress', 106, '2023-09-22 11:15:00'),
(7, 7, '2023-09-23 12:30:00', 'Payment Issue', 'Overcharged for an item', 'Medium', 'Closed', 107, '2023-09-23 13:00:00'),
(8, 8, '2023-09-24 15:10:00', 'Account Issue', 'Password reset not working', 'High', 'In Progress', 108, '2023-09-24 16:00:00'),
(9, 9, '2023-09-25 09:50:00', 'Technical Issue', 'Graphics glitch in game', 'Low', 'Open', 109, '2023-09-25 10:30:00'),
(10, 10, '2023-09-26 11:25:00', 'Other', 'Suggestion for improving gameplay', 'Low', 'Closed', 110, '2023-09-26 12:00:00');
