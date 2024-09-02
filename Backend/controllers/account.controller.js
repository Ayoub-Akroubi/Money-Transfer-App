const db = require('../database/connection'); 


exports.deposit = async (req, res) => {
  const { accountId, amount } = req.body;

  if (amount <= 0) {
    return res.status(400).json({ message: "Deposit amount must be greater than zero" });
  }

  const query = `UPDATE Accounts SET balance = balance + ? WHERE accountId = ?`;

  try {
    const [result] = await db.execute(query, [amount, accountId]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Account not found" });
    } else {
      return res.status(200).json({ message: `Deposit of ${amount} successful` });
    }
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};

exports.withdraw = async (req, res) => {
  const { accountId, amount } = req.body;

  if (amount <= 0) {
    return res.status(400).json({ message: "Withdrawal amount must be greater than zero" });
  }

  const checkBalanceQuery = `SELECT balance FROM Accounts WHERE accountId = ?`;

  try {
    const [results] = await db.execute(checkBalanceQuery, [accountId]);

    if (results.length === 0) {
      return res.status(404).json({ message: "Account not found" });
    }

    const currentBalance = results[0].balance;

    if (currentBalance < amount) {
      return res.status(400).json({ message: "Insufficient funds" });
    }

    const updateQuery = `UPDATE Accounts SET balance = balance - ? WHERE accountId = ?`;
    const [result] = await db.execute(updateQuery, [amount, accountId]);

    return res.status(200).json({ message: `Withdrawal of ${amount} successful` });

  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};

exports.getBalance = async (req, res) => {
  const { userId } = req.query;

  const query = `SELECT balance FROM Accounts WHERE userId = ?`;

  try {
    const [results] = await db.execute(query, [userId]);

    if (results.length === 0) {
      return res.status(404).json({ message: "Account not found" });
    }

    const balance = results[0].balance;
    return res.status(200).json({ balance });

  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};