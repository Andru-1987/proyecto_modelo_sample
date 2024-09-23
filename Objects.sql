-- Objects creation

use first_task;

-- Vista 1

DROP VIEW IF EXISTS Player_Items_View;

CREATE VIEW Player_Items_View AS 
SELECT
    vi.Item_Name, 
    vi.Description, 
    vi.Price, 
    vi.Category,
    p.Name,
    p.ID_Player
FROM
	Players p 
LEFT JOIN
	Virtual_Items vi ON p.ID_Player = vi.ID_Player
ORDER BY -- Ordenar los precios de los items y mostrar los 3 mas caros
	vi.Price DESC
LIMIT 3;

-- Vista 2

DROP VIEW IF EXISTS Item_Economic_Activity_View;

CREATE VIEW Item_Economic_Activity_View AS 
SELECT
	vi.Item_Name,
    COUNT( ft.ID_Transaction ) AS Transaction_Count, -- Contar el numero de transacciones del item
    SUM( ft.Amount ) AS Total_Revenue -- Sumar el numero de dinero recaudado
FROM
	Virtual_Items vi
LEFT JOIN
	Financial_Transactions ft ON vi.ID_Item = ft.ID_Player
GROUP BY
	vi.Item_Name
ORDER BY
	Total_Revenue DESC;




-- Funcion 1

DROP FUNCTION IF EXISTS Get_Total_Spending;

DELIMITER //
CREATE FUNCTION Get_Total_Spending( p_ID_Player INT )
RETURNS DECIMAL( 10, 2 ) DETERMINISTIC READS SQL DATA
BEGIN
	DECLARE total_spent DECIMAL( 10, 2 );
    
    SELECT SUM( Amount ) INTO total_spent -- Sumar todas las transacciones del jugador
    FROM Financial_Transactions
    WHERE ID_Player = p_ID_Player;
    
    RETURN total_spent;
END //
DELIMITER ;


-- Funcion 2

DROP FUNCTION IF EXISTS Get_Average_Spending_Status;

DELIMITER //
CREATE FUNCTION Get_Average_Spending_Status( p_ID_Player INT )
RETURNS VARCHAR( 255 )
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE player_average DECIMAL( 10, 2 );
    DECLARE overall_average DECIMAL( 10, 2 );
    DECLARE status_message VARCHAR( 255 );

    SELECT AVG( Amount ) INTO player_average -- Calcular el gasto promedio del jugador
    FROM Financial_Transactions
    WHERE ID_Player = p_ID_Player;

    SELECT AVG( Amount ) INTO overall_average -- Calcular el gasto promedio general
    FROM Financial_Transactions;

    IF player_average > overall_average THEN -- Comparar el gasto promedio del jugador con el gasto promedio general
        SET status_message = 'This player spends more than overall';
    ELSEIF player_average < overall_average THEN
        SET status_message = 'This player spends less than overall';
    ELSE
        SET status_message = 'This player spends overall';
    END IF;

    RETURN status_message;  -- Retornar el mensaje final
END //
DELIMITER ;





-- Procedimiento 1

DROP PROCEDURE IF EXISTS Update_Support_Ticket_Status;

DELIMITER //
CREATE PROCEDURE Update_Support_Ticket_Status(
    IN p_ID_Ticket INT,
    IN p_New_Status ENUM('Open', 'In Progress', 'Resolved', 'Closed')
)
BEGIN
    UPDATE Support_and_Customer_Service
    SET Ticket_Status = p_New_Status, Last_Updated_Date = NOW() -- Actualizar el status del ticket y establecer el ultimo tiempo de actualizacion al momento
    WHERE ID_Ticket = p_ID_Ticket;
END //
DELIMITER ;

-- Procedimiento 2

 DROP PROCEDURE IF EXISTS Register_Transaction;

DELIMITER //
CREATE PROCEDURE Register_Transaction(
    IN p_ID_Player INT,
    IN p_Transaction_Type ENUM('Purchase', 'Refund'),
    IN p_Amount DECIMAL(10, 2),
    IN p_Currency VARCHAR(10),
    IN p_Payment_Method VARCHAR(50)
)
BEGIN
    DECLARE total_spent DECIMAL(10, 2);
    DECLARE player_exists INT;


    SELECT COUNT(*) INTO player_exists -- Verificar si el jugador existe
    FROM Players
    WHERE ID_Player = p_ID_Player;

    IF player_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El jugador no existe.';
    ELSEIF p_Amount <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto debe ser mayor que cero.';
    ELSE
        -- Registrar la transacción
        INSERT INTO Financial_Transactions (ID_Player, Transaction_Type, Date_Time, Amount, Currency, Payment_Method, Transaction_Status)
        VALUES (p_ID_Player, p_Transaction_Type, NOW(), p_Amount, p_Currency, p_Payment_Method, 'Completed');
    END IF;
END //
DELIMITER ;




-- Trigger 1

DROP TRIGGER IF EXISTS Validate_Transaction_Amount;

DELIMITER //
CREATE TRIGGER Validate_Transaction_Amount
BEFORE INSERT ON Financial_Transactions
FOR EACH ROW
BEGIN
    IF NEW.Amount < 0 THEN -- Verificar que el monto no sea negativo
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El monto de la transacción no puede ser negativo.';
    END IF;
END //
DELIMITER ;




-- Trigger 2

DROP TRIGGER IF EXISTS Validate_Payment_Method;

DELIMITER //
CREATE TRIGGER Validate_Payment_Method
BEFORE INSERT ON Financial_Transactions
FOR EACH ROW
BEGIN
    DECLARE valid_method INT;

    -- Verificar si el método de pago es uno de los permitidos
    SELECT COUNT(*) INTO valid_method
    FROM (SELECT 'Credit Card' AS Method
          UNION ALL SELECT 'PayPal'
          UNION ALL SELECT 'Bank Transfer') AS AllowedMethods
    WHERE Method = NEW.Payment_Method;

    -- Si el método de pago no es válido, lanzar un error
    IF valid_method = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El método de pago no es válido.';
    END IF;
END //
DELIMITER ;
