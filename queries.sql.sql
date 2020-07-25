1. SELECT COUNT(u_id) FROM users;

2. SELECT COUNT(transfer_id) FROM transfers WHERE send_amount_currency='CFA';

3. SELECT COUNT(DISTINCT u_id) FROM transfers WHERE send_amount_currency='CFA';

4. SELECT COUNT(atx_id) FROM agent_transactions WHERE when_created BETWEEN '2018-01-01 00:00:00' AND '2018-12-31 23:59:59'
   GROUP BY EXTRACT(MONTH FROM when_created);

5. SELECT SUM(case when amount>0 THEN amount else 0 END) AS withdrawal, 
   SUM(case when amount<0 THEN amount else 0 END) AS deposit, 
   case WHEN ((sum(case when amount>0 THEN amount else 0 END))>((sum (case when amount <0 Then amount else 0 END)))*-1)
   THEN 'netwithdrawer' ELSE 'netdepositor' END AS agent_status,
   count(agent_id) from agent_transactions 
   WHERE when_created BETWEEN (now() -'1 week'::INTERVAL) AND now();

6. SELECT COUNT(agent_transactions.atx_id) AS "atx volume city summary", agents.city
   FROM agent_transactions 
   JOIN  agents ON agent_transactions.agent_id=agents.agent_id
   WHERE agent_transactions.when_created BETWEEN (now() -'1 week'::INTERVAL) AND now()
   GROUP BY agents.city;

7. SELECT COUNT(agent_transactions.atx_id) AS "atx volume city summary", agents.city, agents.country
   FROM agent_transactions 
   JOIN  agents ON agent_transactions.agent_id=agents.agent_id
   WHERE agent_transactions.when_created BETWEEN (now() -'1 week'::INTERVAL) AND now()
   GROUP BY agents.city,agents.country;

8. SELECT SUM(transfers.send_amount_scalar) AS Volume,transfers.kind AS Transfer_kind, wallets.ledger_location AS Country
   FROM transfers
   INNER JOIN wallets ON transfers.source_wallet_id=wallets.wallet_id
   WHERE (transfers.when_created > (now() - INTERVAL '1 week'))
   GROUP BY transfers.kind,wallets.ledger_location;

9.SELECT SUM(transfers.send_amount_scalar) AS Volume,transfers.kind AS Transfer_kind, wallets.ledger_location AS Country,
  COUNT(transfers.source_wallet_id) AS Unique_senders, COUNT(transfers.transfer_id) AS Transaction_count
  FROM transfers
  INNER JOIN wallets ON transfers.source_wallet_id=wallets.wallet_id
  WHERE (transfers.when_created > (now() - INTERVAL '1 week'))
  GROUP BY transfers.kind,wallets.ledger_location; 

10. SELECT source_wallet_id, send_amount_scalar
    FROM transfers
    WHERE send_amount_currency='CFA' AND send_amount_scalar>10000000 AND when_created>CURRENT_DATE-INTERVAL '1 month'; 