const db = require('../database/connection');

exports.updateProfile = async (req, res) => {
  const { name, phoneNumber, address } = req.body;
  const userId = req.user.userId;

  const query = `UPDATE Users SET name = ?, phoneNumber = ?, address = ? WHERE userId = ?`;

  try {
    const [result] = await db.execute(query, [name, phoneNumber, address, userId]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "User not found" });
    } else {
      return res.status(200).json({ message: "Profile updated successfully" });
    }
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};

exports.switchRole = async (req, res) => {
  const userId = req.user.userId;
  const { newRole } = req.body;

  if (!['sender', 'receiver', 'agent'].includes(newRole)) {
    return res.status(400).json({ message: 'Invalid role' });
  }

  const query = `UPDATE Users SET role = ? WHERE userId = ?`;

  try {
    const [result] = await db.execute(query, [newRole, userId]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Role not switched" });
    } else {
      return res.status(200).json({ message: `Role switched to ${newRole} successfully` });
    }
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
};
