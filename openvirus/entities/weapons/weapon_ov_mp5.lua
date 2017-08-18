-- MP5

SWEP.PrintName = "#weapon_ov_mp5"
SWEP.UseHands = true

SWEP.ViewModelFOV = 56
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "OV_MP5"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 3
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 2
SWEP.SlotPos = 5
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

SWEP.CSMuzzleFlashes = true


-- Initialize the weapon
function SWEP:Initialize()

    self:SetHoldType( "smg" )

end


-- Primary attack
function SWEP:PrimaryAttack()

    if ( !self:CanPrimaryAttack() ) then return end

    self.Weapon:EmitSound( "Weapon_MP5Navy.Single" )

    self:ShootBullet( 11, 1, 0.05 )

    self:TakePrimaryAmmo( 1 )

    self.Owner:ViewPunch( Angle( -0.5, 0, 0 ) )

    self:SetNextPrimaryFire( CurTime() + 0.09 )

end


-- Secondary attack
function SWEP:SecondaryAttack()

    return

end


if ( CLIENT ) then

	-- Draw the weapon selection box
	function SWEP:DrawWeaponSelection( x, y, w, h, a )
	
		surface.SetFont( "CSTRIKETypeDeath" )
		surface.SetTextColor( 255, 255, 255, a )
		surface.SetTextPos( x + ( w / 3 ), y + ( h / 2.5 ) )
		surface.DrawText( "x" )
	
	end

end
