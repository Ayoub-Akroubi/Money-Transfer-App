const db = require('../database/connection'); 
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { JWT_SECRET } = require('../config/jwt.config');

exports.register = async (req, res) => {
  const { name, email, phoneNumber, address, password } = req.body;

  try {
      const hashedPassword = await bcrypt.hash(password, 10);

      const query = `INSERT INTO Users (name, email, phoneNumber, address, password) VALUES (?, ?, ?, ?, ?)`;

      await db.query(query, [name, email, phoneNumber, address, hashedPassword]);

      res.status(201).json({ message: "User registered successfully!" });
  } catch (err) {
      res.status(500).json({ error: err.message });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;

  const query = `SELECT * FROM Users WHERE email = ?`;

  try {
      const [results] = await db.query(query, [email]);

      if (results.length === 0) {
          return res.status(401).json({ message: "Invalid email or password" });
      }

      const user = results[0];
      const match = await bcrypt.compare(password, user.password);

      if (match) {
          const token = jwt.sign({ userId: user.userId }, JWT_SECRET, { expiresIn: '24h' });
          res.status(200).json({ 
              userId: user.userId,
              token: token,
              role: user.role,
          });
      } else {
          res.status(401).json({ message: "Invalid email or password" });
      }
  } catch (err) {
      res.status(500).json({ error: err.message });
  }
};