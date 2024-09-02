const express = require('express');
const router = express.Router();
const userController = require('../controllers/user.controller');
const authenticateToken = require('../middlewares/auth.middleware');

router.put('/updateProfile', authenticateToken, userController.updateProfile);
router.put('/switchRole', authenticateToken, userController.switchRole);

module.exports = router;