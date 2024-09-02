const db = require('../database/connection'); 

exports.getTransactions = async (req, res) => {
  const agentId  = req.user.userId;
  try {
    const [transactions] = await db.query('SELECT * FROM Transactions WHERE agentId = ? AND status = ?', [agentId, 'pending']);

    if (transactions.length === 0 ) {
        return res.status(201).json({ message: 'No transactions found' });
    }

    res.status(200).json(transactions);
  } catch (error) {
      console.error('Error fetching transactions:', error);
      res.status(500).json({ message: 'An error occurred while fetching transactions' });
  }

};

exports.initiateTransfer = async (req, res) => {
  const { fromAccountId, toAccountId,agentId, amount } = req.body;
  
  try {
      const [fromAccount] = await db.query('SELECT * FROM Accounts WHERE accountId = ?', [fromAccountId]);
      const [toAccount] =  await db.query('SELECT * FROM Accounts WHERE accountId = ?', [toAccountId]);
      const [agent] =  await db.query('SELECT * FROM users WHERE role = "agent" AND userId= ?', [agentId]);

      if (fromAccount.length === 0 || toAccount.length === 0 || agent.length === 0) {
          return res.status(404).json({ message: 'One or both accounts not found' });
      }

      if (fromAccount[0].balance < amount) {
          return res.status(400).json({ message: 'Insufficient balance' });
      }

      const transactionId = 'txn_' + Date.now();
      await db.query('INSERT INTO Transactions (transactionId, senderId, receiverId, agentId, amount, status) VALUES (?, ?, ?, ?, ?, ?)', 
          [transactionId, fromAccount[0].userId, toAccount[0].userId, agent[0].agentId, amount, 'pending']);

      res.status(201).json({ message: 'Transaction initiated successfully', transactionId });
  } catch (error) {
    console.error('Error initiating transaction:', error); 
      res.status(500).json({ message: 'An error occurred while initiating the transaction', error });
  }
};

exports.matchAgent = async (req, res) => {
  const { transactionId, agentId } = req.body;

  try {
      const [transaction] = await db.query('SELECT * FROM Transactions WHERE transactionId = ? AND status = ?', [transactionId, 'pending']);
      if (!transaction.length) {
          return res.status(404).json({ message: 'Transaction not found or not in pending state' });
      }

      await db.query('UPDATE Transactions SET agentId = ?, status = ? WHERE transactionId = ?', 
          [agentId, 'agent_matched', transactionId]);

      res.status(200).json({ message: 'Agent matched successfully' });
  } catch (error) {
      res.status(500).json({ message: 'An error occurred while matching the agent', error });
  }
};

exports.completeTransaction = async (req, res) => {
  const { transactionId } = req.body;

  try {
      const [transaction] = await db.query('SELECT * FROM Transactions WHERE transactionId = ? AND status = ?', [transactionId, 'agent_matched']);
      if (!transaction.length) {
          return res.status(404).json({ message: 'Transaction not found or not in agent_matched state' });
      }

      await db.query('UPDATE Transactions SET status = ?, completedAt = NOW() WHERE transactionId = ?', 
          ['completed', transactionId]);

      res.status(200).json({ message: 'Transaction completed successfully' });
  } catch (error) {
      res.status(500).json({ message: 'An error occurred while completing the transaction', error });
  }
};
